import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cart = Get.find<CartController>();

    // load cart first time
    if (cart.items.isEmpty) {
      cart.fetchCart();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF155780),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("My Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: cart.fetchCart, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Obx(() {
        if (cart.loading.value && cart.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cart.error.value.isNotEmpty && cart.items.isEmpty) {
          return Center(child: Text(cart.error.value));
        }

        return Column(
          children: [
            Expanded(
              child: cart.items.isEmpty
                  ? const Center(child: Text("Cart is empty"))
                  : ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: cart.items.length,
                itemBuilder: (_, i) {
                  final x = cart.items[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 12, offset: Offset(0, 6)),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(x.imageUrl, width: 64, height: 64, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(x.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Text(x.priceText, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text("Line: ${x.lineTotalText}", style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => cart.updateQty(x.productId, x.qty - 1),
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                            Text("${x.qty}", style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              onPressed: () => cart.updateQty(x.productId, x.qty + 1),
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFF3AA3FF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  _Row(title: "Subtotal", value: cart.subtotalText),
                  const SizedBox(height: 6),
                  const _Row(title: "Delivery", value: "Free"),
                  const Divider(color: Colors.white24),
                  _Row(title: "Total", value: cart.subtotalText, bold: true),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Obx(() {
                final busy = cart.loading.value;
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: busy || cart.items.isEmpty
                      ? null
                      : () => Get.to(() => const CheckoutScreen()),
                  child: Text(busy ? "Loading..." : "Proceed to Checkout",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}

class _Row extends StatelessWidget {
  final String title;
  final String value;
  final bool bold;
  const _Row({required this.title, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        Text(value, style: TextStyle(color: Colors.white, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }
}
