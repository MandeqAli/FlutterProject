import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/orders_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/order_row.dart';

class CustomersPage extends StatelessWidget {
  CustomersPage({super.key});

  final OrdersController c = Get.put(OrdersController(), permanent: true);
  final ThemeController themeC = Get.find<ThemeController>();

  static const sidebarBg = Color(0xFF0B1220);
  static const activeBg = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF4FAFB);
    final card = isDark ? const Color(0xFF111827) : Colors.white;
    final text = isDark ? Colors.white : const Color(0xFF0F172A);
    final sub = isDark ? Colors.white70 : const Color(0xFF64748B);
    final border = isDark ? Colors.white12 : const Color(0xFFE5E7EB);

    return Scaffold(
      backgroundColor: bg,
      body: Row(
        children: [
          // ================= SIDEBAR =================
          Container(
            width: 90,
            decoration: const BoxDecoration(
              color: sidebarBg,
              border: Border(
                right: BorderSide(color: Color.fromARGB(30, 255, 255, 255)),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 18),
                InkWell(
                  onTap: () => Get.offAllNamed("/dashboard"),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: activeBg.withOpacity(.15),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(Icons.medication, color: activeBg),
                  ),
                ),
                const SizedBox(height: 22),

                _SideIcon(
                  icon: Icons.dashboard,
                  active: false,
                  onTap: () => Get.offAllNamed("/dashboard"),
                ),
                _SideIcon(
                  icon: Icons.receipt_long,
                  active: true,
                  onTap: () => Get.toNamed("/customers"),
                ),
                const SizedBox(height: 12),
                _SideIcon(
                  icon: Icons.verified_outlined,
                  active: false,
                  onTap: () => Get.toNamed("/order_details"),
                ),

                const Spacer(),
                const SizedBox(height: 18),
              ],
            ),
          ),

          // ================= CONTENT =================
          Expanded(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
                child: Column(
                  children: [
                    // Top bar
                    Row(
                      children: [
                        Text(
                          "Pharmacy",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: text,
                          ),
                        ),
                        const SizedBox(width: 14),

                        Expanded(
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: card,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: border),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 14),
                                Icon(Icons.search, size: 20, color: sub),
                                const SizedBox(width: 10),
                                Text("Search...", style: TextStyle(color: sub)),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Obx(() {
                          final on = themeC.isDark.value;
                          return InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: themeC.toggle,
                            child: Container(
                              height: 44,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: border),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    on ? Icons.dark_mode : Icons.light_mode,
                                    size: 18,
                                    color: sub,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    on ? "Dark" : "Light",
                                    style: TextStyle(color: sub),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                        const SizedBox(width: 10),

                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => Get.offAllNamed("/login"),
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xFF0B1220)
                                  : const Color(0xFF0F172A),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Customers",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    _HeaderRow(border: border, card: card, textColor: text),
                    const SizedBox(height: 10),

                    Expanded(
                      child: Obx(() {
                        if (c.loading.value)
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        if (c.error.value.isNotEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  c.error.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: text),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: c.fetchOrders,
                                  child: const Text("Retry"),
                                ),
                              ],
                            ),
                          );
                        }

                        if (c.orders.isEmpty) {
                          return Center(
                            child: Text(
                              "No customers/orders yet. Place an order from cart to see it here.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: sub),
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: c.orders.length,
                          itemBuilder: (_, i) {
                            final o = c.orders[i];
                            final int id = o.id;

                            final Map<String, dynamic> orderMap = {
                              "id": o.id,
                              "userName": o.userName,
                              "userEmail": o.userEmail,
                              "userPhone": o.userPhone,
                              "status": o.status,
                              "createdAt": o.createdAt,
                              "lines": o.lines,
                              "totalCents": o.totalCents,
                            };

                            return OrderRow(
                              order: orderMap,
                              onConfirm: () async {
                                await c.setStatus(id, "confirm");
                                Get.toNamed(
                                  "/order_details",
                                  arguments: orderMap,
                                );
                              },
                              onPending: () {},

                              // ✅ FIXED Cancel
                              onCancel: () async {
                                final ok = await Get.dialog<bool>(
                                  AlertDialog(
                                    title: const Text("Cancel order?"),
                                    content: const Text(
                                      "Are you sure you want to cancel and delete this order?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Get.back(result: false),
                                        child: const Text("No"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Get.back(result: true),
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  ),
                                );

                                if (ok == true) {
                                  await c.deleteOrder(id);
                                  c.orders.removeWhere((o) => o.id == id);
                                  c.orders.refresh(); // ✅ update UI immediately
                                }
                              },
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.border,
    required this.card,
    required this.textColor,
  });
  final Color border;
  final Color card;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(18),
        color: card,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text("Customer", style: TextStyle(color: textColor)),
          ),
          Expanded(
            flex: 2,
            child: Text("Phone", style: TextStyle(color: textColor)),
          ),
          Expanded(
            flex: 3,
            child: Text("Purchase Details", style: TextStyle(color: textColor)),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("Amount", style: TextStyle(color: textColor)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text("Status", style: TextStyle(color: textColor)),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

class _SideIcon extends StatelessWidget {
  const _SideIcon({
    required this.icon,
    required this.active,
    required this.onTap,
  });
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  static const activeBg = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: active ? activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(icon, color: active ? Colors.white : Colors.white70),
        ),
      ),
    );
  }
}
