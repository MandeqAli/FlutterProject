import 'package:get/get.dart';
import '../services/api.dart';

class OrderRowModel {
  final int id;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String status;
  final String createdAt;
  final List<Map<String, dynamic>> lines;
  final int totalCents;

  OrderRowModel({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.status,
    required this.createdAt,
    required this.lines,
    required this.totalCents,
  });

  factory OrderRowModel.fromJson(Map<String, dynamic> j) {
    final rawLines = (j["lines"] is List) ? (j["lines"] as List) : [];
    return OrderRowModel(
      id: (j["id"] is int) ? j["id"] : int.tryParse("${j["id"]}") ?? 0,
      userName: (j["userName"] ?? "Customer").toString(),
      userEmail: (j["userEmail"] ?? "").toString(),
      userPhone: (j["userPhone"] ?? "-").toString(),
      status: (j["status"] ?? "pending").toString(),
      createdAt: (j["createdAt"] ?? "").toString(),
      totalCents: (j["totalCents"] is int)
          ? j["totalCents"]
          : int.tryParse("${j["totalCents"]}") ?? 0,
      lines: rawLines
          .where((e) => e is Map)
          .map((e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  String get productName {
    if (lines.isNotEmpty) return (lines.first["title"] ?? "Item").toString();
    return "Item";
  }

  int get qty {
    if (lines.isNotEmpty) {
      final v = lines.first["qty"];
      if (v is int) return v;
      return int.tryParse("$v") ?? 1;
    }
    return 1;
  }

  double get amount => totalCents / 100.0;
}

class OrdersController extends GetxController {
  final RxBool loading = false.obs;
  final RxString error = "".obs;
  final RxList<OrderRowModel> orders = <OrderRowModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      loading.value = true;
      error.value = "";

      // ✅ Your backend list: GET /api/orders -> {success, data:[...]}
      final res = await Api.get("/api/orders");
      final list = (res["data"] as List? ?? []);
      orders.assignAll(
        list
            .map(
              (e) => OrderRowModel.fromJson((e as Map).cast<String, dynamic>()),
            )
            .toList(),
      );
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> setStatus(int orderId, String status) async {
    try {
      await Api.post("/api/orders/$orderId/status", {"status": status});

      final idx = orders.indexWhere((x) => x.id == orderId);
      if (idx != -1) {
        final old = orders[idx];
        orders[idx] = OrderRowModel(
          id: old.id,
          userName: old.userName,
          userEmail: old.userEmail,
          userPhone: old.userPhone,
          status: status,
          createdAt: old.createdAt,
          lines: old.lines,
          totalCents: old.totalCents,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // ✅ THIS IS THE IMPORTANT PART
  Future<void> deleteOrder(int orderId) async {
    // optimistic remove (UI updates instantly)
    final idx = orders.indexWhere((x) => x.id == orderId);
    if (idx == -1) return;

    final removed = orders[idx];
    orders.removeAt(idx);

    try {
      await Api.post("/api/orders/$orderId/delete", {});
      // success -> keep removed
      Get.snackbar("Deleted", "Order removed successfully");
    } catch (e) {
      // restore if backend failed
      orders.insert(idx, removed);
      Get.snackbar("Delete failed", e.toString());
    }
  }
}
