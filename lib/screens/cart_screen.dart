import 'package:flutter/material.dart';
import 'package:pharmacy/screens/checkout_screen.dart';
import '../widgets/cart_item.dart';
import '../widgets/summary_row.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 222, 231, 227),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Cart items (scrollable)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 8),
              children: const [
                CartItem(
                  name: "Panadol Extra",
                  price: 12.99,
                  image: "assets/panadol.jpeg",
                ),
                CartItem(
                  name: "Claritin",
                  price: 18.99,
                  image: "assets/claritin.jpeg",
                ),
              ],
            ),
          ),

          // Summary section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.5 * 255).round()),

                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              children: const [
                SummaryRow(title: "Subtotal", value: "\$31.98"),
                SizedBox(height: 6),
                SummaryRow(title: "Delivery", value: "Free"),
                Divider(color: Colors.grey),
                SummaryRow(title: "Total", value: "\$31.98", bold: true),
              ],
            ),
          ),

          // Checkout button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
              child: const Text(
                "Proceed to Checkout",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
