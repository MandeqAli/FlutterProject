import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (Get.arguments ?? {}) as Map;

    final int id = args["id"] ?? 0;
    final String userName = (args["userName"] ?? "Customer").toString();
    final String userEmail = (args["userEmail"] ?? "").toString();
    final String userPhone = (args["userPhone"] ?? "-").toString();
    final String status = (args["status"] ?? "pending").toString();

    final List lines = (args["lines"] ?? []) as List;

    final int totalCents = (args["totalCents"] is int)
        ? args["totalCents"]
        : int.tryParse("${args["totalCents"]}") ?? 0;

    final double total = totalCents / 100.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4FAFB),
        elevation: 0,
        title: const Text(
          "Order Details",
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Customer", style: _title()),
                      const SizedBox(height: 10),
                      Text("Name: $userName"),
                      if (userEmail.isNotEmpty) Text("Email: $userEmail"),
                      Text("Phone: $userPhone"),
                      const SizedBox(height: 10),
                      Text("Order ID: #$id"),
                      Text("Status: ${status.toUpperCase()}"),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Purchase Details", style: _title()),
                      const SizedBox(height: 10),

                      if (lines.isEmpty)
                        const Text("No items found.")
                      else
                        ...lines.map((e) {
                          final m = (e as Map).cast<String, dynamic>();
                          final title = (m["title"] ?? "Item").toString();
                          final qty = m["qty"] ?? 1;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Text("Qty: $qty"),
                              ],
                            ),
                          );
                        }).toList(),

                      const Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Total: ${total.toStringAsFixed(2)} USD",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _title() =>
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w900);
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: child,
    );
  }
}
