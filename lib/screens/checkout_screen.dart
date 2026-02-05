import 'package:flutter/material.dart';
import 'package:pharmacy/widgets/success_dialog.dart';
import '../widgets/card_box.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Shipping Address"),
            CardBox(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("John Smith"),
                subtitle: const Text("New York, USA"),
                trailing: TextButton(
                  onPressed: () {},
                  child: const Text("Edit",
                      style: TextStyle(color: Colors.orange)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Payment Method"),
            CardBox(
              child: ListTile(
                leading: const Icon(Icons.credit_card),
                title: const Text("Visa **** 1234"),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => const SuccessDialog(),
                );
              },
              child: const Text("Confirm Order"),
            ),
          ],
        ),
      ),
    );
  }
}


