import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../widgets/success_dialog.dart';
import '../pages/categories_page.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cart = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Color(0xFF155780),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Shipping Address"),
            const SizedBox(height: 8),
            const Card(
              child: ListTile(
                leading: Icon(Icons.location_on),
                title: Text("John Smith"),
                subtitle: Text("Mogadishu, Somalia"),
              ),
            ),
            const SizedBox(height: 16),

            const Text("Payment Method"),
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
                    await cart.checkout();

                    // ✅ Congratulations dialog
                    await showDialog(
                      context: context,
                      builder: (_) => const SuccessDialog(),
                    );

                    // ✅ after OK → back to categories
                    Get.offAll(() => CategoriesPage());
                  } catch (e) {
                    Get.snackbar("Error", e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white);
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
