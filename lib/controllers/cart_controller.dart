import 'package:get/get.dart';
import '../models/cart_models.dart';
import '../services/api.dart';

class CartController extends GetxController {
  final RxBool loading = false.obs;
  final RxString error = "".obs;

  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxInt subtotalCents = 0.obs;

  String get subtotalText =>
      "\$${(subtotalCents.value / 100).toStringAsFixed(2)}";

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      loading.value = true;
      error.value = "";

      final res = await Api.get("/api/cart");

      // ✅ handle both: {success:true,data:{...}} OR direct data
      final data = res["data"] ?? res ?? {};
      final list = (data["items"] as List? ?? []);

      items.assignAll(
        list.map((e) => CartItemModel.fromJson((e as Map).cast<String, dynamic>())).toList(),
      );

      final sc = data["subtotalCents"];
      subtotalCents.value = sc is int ? sc : int.tryParse("$sc") ?? 0;
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> addToCart(int productId, int qty) async {
    try {
      loading.value = true;
      error.value = "";

      final res = await Api.post("/api/cart/add", {
        "productId": productId,
        "qty": qty,
      });

      final data = res["data"] ?? res ?? {};
      final list = (data["items"] as List? ?? []);

      items.assignAll(
        list.map((e) => CartItemModel.fromJson((e as Map).cast<String, dynamic>())).toList(),
      );

      final sc = data["subtotalCents"];
      subtotalCents.value = sc is int ? sc : int.tryParse("$sc") ?? 0;
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      loading.value = false;
    }
  }

  Future<void> updateQty(int productId, int qty) async {
    try {
      loading.value = true;
      error.value = "";

      final res = await Api.post("/api/cart/update", {
        "productId": productId,
        "qty": qty,
      });

      final data = res["data"] ?? res ?? {};
      final list = (data["items"] as List? ?? []);

      items.assignAll(
        list.map((e) => CartItemModel.fromJson((e as Map).cast<String, dynamic>())).toList(),
      );

      final sc = data["subtotalCents"];
      subtotalCents.value = sc is int ? sc : int.tryParse("$sc") ?? 0;
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> clearCart() async {
    try {
      loading.value = true;
      error.value = "";
      await Api.post("/api/cart/clear", {});

      items.clear();
      subtotalCents.value = 0;
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> checkout({
    required String userName,
    required String userEmail,
    required String userPhone,
  }) async {
    try {
      loading.value = true;
      error.value = "";

      // ✅ If your model uses different fields, adjust here:
      final payloadItems = items
          .map((x) => {
        "productId": x.productId, // must match your CartItemModel
        "qty": x.qty,
      })
          .toList();

      if (payloadItems.isEmpty) {
        throw "Cart is empty";
      }

      final body = {
        "items": payloadItems,
        "userName": userName,
        "userEmail": userEmail,
        "userPhone": userPhone,
        "paymentMethod": "COD",
        "address": {"name": userName, "city": "Mogadishu"},
      };

      await Api.post("/api/orders/checkout", body);

      // ✅ clear UI cart after successful order
      await clearCart();
    } catch (e) {
      error.value = e.toString();
      rethrow;
    } finally {
      loading.value = false;
    }
  }
}
