import 'package:get/get.dart';
import '../services/api.dart';

class OrderRowModel {
  final int id;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String productName;
  final int qty;
  final double amount;
  final String status;

  OrderRowModel({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.productName,
    required this.qty,
    required this.amount,
    required this.status,
  });

  factory OrderRowModel.fromJson(Map<String, dynamic> j) {
    return OrderRowModel(
      id: (j["id"] ?? 0) is int ? j["id"] : int.tryParse("${j["id"]}") ?? 0,

      // ✅ Your backend orders currently do NOT include customer fields.
      // Keep your fields, but fall back safely:
      userName: (j["userName"] ?? "Customer").toString(),
      userEmail: (j["userEmail"] ?? "").toString(),
      userPhone: (j["userPhone"] ?? "-").toString(),

      // ✅ Your backend returns lines: [{title, qty, ...}]
      productName: _pickProductName(j),
      qty: _pickQty(j),

      // ✅ Your backend returns totalCents
      amount: _pickAmount(j),

      // ✅ backend may not return status => default pending
      status: (j["status"] ?? "pending").toString(),
    );
  }

  static String _pickProductName(Map<String, dynamic> j) {
    final lines = (j["lines"] is List) ? (j["lines"] as List) : [];
    if (lines.isNotEmpty && lines.first is Map) {
      final first = (lines.first as Map).cast<String, dynamic>();
      return (first["title"] ?? "Unknown Product").toString();
    }
    return (j["productName"] ?? "Unknown Product").toString();
  }

  static int _pickQty(Map<String, dynamic> j) {
    final lines = (j["lines"] is List) ? (j["lines"] as List) : [];
    if (lines.isNotEmpty && lines.first is Map) {
      final first = (lines.first as Map).cast<String, dynamic>();
      final v = first["qty"];
      if (v is int) return v;
      return int.tryParse("$v") ?? 1;
    }
    final v = j["qty"];
    if (v is int) return v;
    return int.tryParse("$v") ?? 1;
  }

  static double _pickAmount(Map<String, dynamic> j) {
    // backend: totalCents
    final v = j["totalCents"];
    if (v is num) return (v.toDouble() / 100.0);
    final parsed = double.tryParse("${v ?? 0}") ?? 0.0;
    return parsed / 100.0;
  }

  String get initials {
    final parts = userName.trim().split(RegExp(r"\s+"));
    if (parts.length >= 2) return (parts[0][0] + parts[1][0]).toUpperCase();
    if (parts.isNotEmpty && parts[0].isNotEmpty) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return "UN";
  }
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

      // ✅ CHANGED ONLY THIS LINE: your backend endpoint
      final res = await Api.get("/api/orders");

      final list = (res["data"] as List? ?? []);
      orders.assignAll(list.map((e) => OrderRowModel.fromJson(e)).toList());
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Future<void> setStatus(int orderId, String status) async {
    try {
      // ❗ your backend doesn't have this endpoint yet
      // await Api.post("/api/admin/orders/$orderId/status", {"status": status});

      // ✅ keep your logic: update local so UI changes
      final idx = orders.indexWhere((x) => x.id == orderId);
      if (idx != -1) {
        final old = orders[idx];
        orders[idx] = OrderRowModel(
          id: old.id,
          userName: old.userName,
          userEmail: old.userEmail,
          userPhone: old.userPhone,
          productName: old.productName,
          qty: old.qty,
          amount: old.amount,
          status: status,
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> deleteOrder(int orderId) async {
    try {
      // ❗ your backend doesn't have this endpoint yet
      // await Api.post("/api/admin/orders/$orderId/delete", {});

      orders.removeWhere((x) => x.id == orderId);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
