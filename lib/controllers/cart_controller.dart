import 'package:get/get.dart';
import '../models/cart_models.dart';
import '../services/api.dart';

class CartController extends GetxController {
  final RxBool loading = false.obs;
  final RxString error = "".obs;

  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxInt subtotalCents = 0.obs;

  String get subtotalText => "\$${(subtotalCents.value / 100).toStringAsFixed(2)}";

  Future<void> fetchCart() async {
    try {
      loading.value = true;
      error.value = "";

      final res = await Api.get("/api/cart");
      final data = res["data"] ?? {};
      final list = (data["items"] as List? ?? []);

      items.assignAll(list.map((e) => CartItemModel.fromJson(e)).toList());
      subtotalCents.value = (data["subtotalCents"] ?? 0) is int ? data["subtotalCents"] : 0;
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

      final res = await Api.post("/api/cart/add", {"productId": productId, "qty": qty});
      final data = res["data"] ?? {};
      final list = (data["items"] as List? ?? []);

      items.assignAll(list.map((e) => CartItemModel.fromJson(e)).toList());
      subtotalCents.value = (data["subtotalCents"] ?? 0) is int ? data["subtotalCents"] : 0;
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

      final res = await Api.post("/api/cart/update", {"productId": productId, "qty": qty});
      final data = res["data"] ?? {};
      final list = (data["items"] as List? ?? []);

      items.assignAll(list.map((e) => CartItemModel.fromJson(e)).toList());
      subtotalCents.value = (data["subtotalCents"] ?? 0) is int ? data["subtotalCents"] : 0;
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

  Future<void> checkout() async {
    // send items to backend
    final payload = {
      "items": items.map((e) => {"productId": e.productId, "qty": e.qty}).toList(),
      "address": {"name": "John Smith", "city": "Mogadishu"},
      "paymentMethod": "COD",
    };

    await Api.post("/api/orders/checkout", payload);
    await clearCart();
  }
}
