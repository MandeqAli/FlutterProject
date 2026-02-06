import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  static const sidebarBg = Color(0xFF0B1220);
  static const activeBg = Color(0xFF10B981);

  final ThemeController themeC = Get.find<ThemeController>();

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

                // Logo
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
                  active: true,
                  onTap: () => Get.offAllNamed("/dashboard"),
                ),

                _SideIcon(
                  icon: Icons.receipt_long,
                  active: false,
                  onTap: () => Get.toNamed("/customers"),
                ),
                // ✅ REMOVED /products icon
                // _SideIcon(
                //   icon: Icons.category_outlined,
                //   active: false,
                //   onTap: () => Get.toNamed("/categories"),
                // ),
                const SizedBox(height: 12),

                _SideIcon(
                  icon: Icons.category_outlined,
                  active: false,
                  onTap: () => Get.toNamed("/order_details"),
                ),

                // ✅ REMOVED messages icon
                // _SideIcon(
                //   icon: Icons.mail_outline,
                //   active: false,
                //   onTap: () => Get.toNamed("/messages"),
                // ),
                const Spacer(),

                // ✅ KEEP ONLY ONE logout (removed duplicates)
                // _SideIcon(
                //   icon: Icons.logout,
                //   active: false,
                //   onTap: () => Get.offAllNamed("/login"),
                // ),
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

                        // Search
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

                        // Dark mode toggle
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

                        // Logout button (top) ✅ keep (not duplicated in sidebar)
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

                    // Welcome
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome Code Astro!",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: text,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Stat cards
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: "Today's Sales",
                            value: "\$95.00",
                            subtitle: "+2.5% This Month",
                            bg: const Color(0xFFDFF7E9),
                            icon: Icons.lock_outline,
                            cardColor: card,
                            border: border,
                            text: text,
                            sub: sub,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            title: "Available Categories",
                            value: "1,457",
                            subtitle: "+2.5% This Month",
                            bg: const Color(0xFFDCEEFF),
                            icon: Icons.grid_view,
                            cardColor: card,
                            border: border,
                            text: text,
                            sub: sub,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            title: "Expired Medicines",
                            value: "0.00%",
                            subtitle: "+2.5% This Month",
                            bg: const Color(0xFFFFE1E1),
                            icon: Icons.warning_amber_rounded,
                            cardColor: card,
                            border: border,
                            text: text,
                            sub: sub,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _StatCard(
                            title: "System Users",
                            value: "255K",
                            subtitle: "+2.5% This Month",
                            bg: const Color(0xFFEDEBFF),
                            icon: Icons.group_outlined,
                            cardColor: card,
                            border: border,
                            text: text,
                            sub: sub,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Charts row (lightweight placeholders)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Graph Report",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: text,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(Icons.more_horiz, color: sub),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: 220,
                                        height: 220,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: border,
                                            width: 18,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Total",
                                              style: TextStyle(color: sub),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "755K",
                                              style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.w900,
                                                color: text,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 8,
                                    children: [
                                      _LegendDot(
                                        label: "Purchases",
                                        color: const Color(0xFF10B981),
                                        textColor: sub,
                                      ),
                                      _LegendDot(
                                        label: "Suppliers",
                                        color: const Color(0xFF60A5FA),
                                        textColor: sub,
                                      ),
                                      _LegendDot(
                                        label: "Sales",
                                        color: const Color(0xFFF59E0B),
                                        textColor: sub,
                                      ),
                                      _LegendDot(
                                        label: "No Sales",
                                        color: const Color(0xFF94A3B8),
                                        textColor: sub,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: card,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: border),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Total Sales Overview",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: text,
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(Icons.more_horiz, color: sub),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: List.generate(7, (i) {
                                        final h = [
                                          90,
                                          130,
                                          160,
                                          120,
                                          170,
                                          110,
                                          140,
                                        ][i].toDouble();
                                        return Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                            child: Container(
                                              height: h,
                                              decoration: BoxDecoration(
                                                color: isDark
                                                    ? Colors.white12
                                                    : const Color(0xFFE2E8F0),
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.white10
                                            : const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: border),
                                      ),
                                      child: Text(
                                        "Apr, 2025  •  \$298.00K",
                                        style: TextStyle(
                                          color: text,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.bg,
    required this.icon,
    required this.cardColor,
    required this.border,
    required this.text,
    required this.sub,
    required this.isDark,
  });

  final String title;
  final String value;
  final String subtitle;
  final Color bg;
  final IconData icon;

  final Color cardColor;
  final Color border;
  final Color text;
  final Color sub;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDark ? Colors.white10 : bg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: sub,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
                    color: text,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: sub, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.label,
    required this.color,
    required this.textColor,
  });

  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: textColor, fontSize: 12)),
      ],
    );
  }
}
