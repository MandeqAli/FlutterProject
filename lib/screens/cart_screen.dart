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

                CartItem(
                  name: "Brufen 400mg",
                  price: 9.50,
                  image: "assets/brufen.jpeg",
                ),

                // Allergy & Cold

                // Antibiotics
                CartItem(
                  name: "Amoxicillin",
                  price: 15.00,
                  image: "assets/amoxicillin.jpeg",
                ),

                // Vitamins
                CartItem(
                  name: "Vitamin C",
                  price: 6.99,
                  image: "assets/vitaminc.jpg",
                ),
                CartItem(
                  name: "Multivitamin",
                  price: 11.49,
                  image: "assets/multivitamin.jpg",
                ),

                // Skincare 🧴
                CartItem(
                  name: "Nivea Face Cream",
                  price: 8.99,
                  image: "assets/nivea.jpg",
                ),
                CartItem(
                  name: "Vaseline Lotion",
                  price: 5.99,
                  image: "assets/vaseline.jpg",
                ),
                CartItem(
                  name: "Garnier Face Wash",
                  price: 10.50,
                  image: "assets/garnier.jpg",
                ),
                CartItem(
                  name: "Sunscreen SPF 50",
                  price: 14.99,
                  image: "assets/sunscreen.jpg",
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
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.5), blurRadius: 10),
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
