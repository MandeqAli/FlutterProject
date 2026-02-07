import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/orders_controller.dart';
import '../controllers/auth_controller.dart';
import '../widgets/success_dialog.dart';
import '../pages/categories_page.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const _bg = Color(0xFF155780);

  @override
  Widget build(BuildContext context) {
    final CartController cart = Get.find<CartController>();
    final AuthController auth = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping Address",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),

            // ✅ user from AuthController (NO John Smith)
            Obx(() {
              final name = auth.currentUserName.value.trim().isEmpty
                  ? "Customer"
                  : auth.currentUserName.value.trim();

              final email = auth.currentUserEmail.value.trim();

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(name),
                  subtitle: Text(email.isEmpty ? "Mogadishu, Somalia" : email),
                ),
              );
            }),

            const SizedBox(height: 16),

            const Text(
              "Payment Method",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.money),
                title: Text("Cash on Delivery (COD)"),
              ),
            ),

            const Spacer(),

            Obx(() {
              final busy = cart.loading.value;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 55),
                ),
                onPressed: busy
                    ? null
                    : () async {
                  try {
                    final name = auth.currentUserName.value.trim().isEmpty
                        ? "Customer"
                        : auth.currentUserName.value.trim();

                    final email = auth.currentUserEmail.value.trim();
                    final phone = auth.currentUserPhone.value.trim();

                    // ✅ Send logged-in user to checkout
                    await cart.checkout(
                      userName: name,
                      userEmail: email,
                      userPhone: phone,
                    );

                    // ✅ refresh orders list
                    if (Get.isRegistered<OrdersController>()) {
                      await Get.find<OrdersController>().fetchOrders();
                    }

                    await showDialog(
                      context: context,
                      builder: (_) => const SuccessDialog(),
                    );

                    Get.offAll(() => CategoriesPage());
                  } catch (e) {
                    Get.snackbar(
                      "Error",
                      e.toString(),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.black87,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Text(busy ? "Processing..." : "Confirm Order"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
