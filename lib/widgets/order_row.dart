import 'package:flutter/material.dart';

class OrderRow extends StatefulWidget {
  const OrderRow({
    super.key,
    required this.order,
    required this.onConfirm,
    required this.onPending,
    required this.onCancel,
  });

  final Map<String, dynamic> order;
  final Future<void> Function() onConfirm;
  final Future<void> Function() onPending;
  final Future<void> Function() onCancel;

  @override
  State<OrderRow> createState() => _OrderRowState();
}

class _OrderRowState extends State<OrderRow> {
  bool open = false;

  Color _statusColor(String s) {
    final v = s.toLowerCase();
    if (v == "confirm" || v == "confirmed") return const Color(0xFF10B981);
    if (v == "cancel" || v == "cancelled") return const Color(0xFFEF4444);
    return const Color(0xFFF59E0B);
  }

  String _statusText(String s) {
    final v = s.trim();
    if (v.isEmpty) return "Pending";
    return v[0].toUpperCase() + v.substring(1);
  }

  String _initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r"\s+"))
        .where((e) => e.isNotEmpty)
        .toList();
    if (parts.length >= 2) return (parts[0][0] + parts[1][0]).toUpperCase();
    if (parts.isNotEmpty && parts[0].length >= 2) {
      return parts[0].substring(0, 2).toUpperCase();
    }
    if (parts.isNotEmpty) return parts[0][0].toUpperCase();
    return "CU";
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.order;

    final String userName = (o["userName"] ?? "Customer").toString();
    final String userEmail = (o["userEmail"] ?? "").toString();
    final String userPhone = (o["userPhone"] ?? "-").toString();

    final List lines = (o["lines"] ?? []) as List;
    final Map<String, dynamic>? firstItem = lines.isNotEmpty
        ? (lines.first as Map).cast<String, dynamic>()
        : null;

    final productName = firstItem?["title"] ?? "Unknown product";
    final qty = firstItem?["qty"] ?? 1;

    final int totalCents = (o["totalCents"] is int)
        ? o["totalCents"]
        : int.tryParse("${o["totalCents"]}") ?? 0;
    final double amount = totalCents / 100.0;

    final String status = (o["status"] ?? "pending").toString();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// Overlay to close menu when clicking outside
        if (open)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.deferToChild,
              onTap: () => setState(() => open = false),
              child: const SizedBox.expand(),
            ),
          ),

        Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFF1F5F9)),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _initials(userName),
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF047857),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (userEmail.isNotEmpty)
                            Text(
                              userEmail,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(flex: 2, child: Text(userPhone)),

              Expanded(
                flex: 3,
                child: Text(
                  "Item: $productName • Qty: $qty",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${amount.toStringAsFixed(2)} USD",
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              Expanded(
                flex: 2,
                child: Text(
                  _statusText(status),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _statusColor(status),
                  ),
                ),
              ),

              SizedBox(
                width: 40,
                child: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => setState(() => open = !open),
                ),
              ),
            ],
          ),
        ),

        if (open)
          Positioned(
            right: 10,
            top: 70,
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 260,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    _ActionItem(
                      iconBg: const Color(0xFFECFDF5),
                      iconColor: const Color(0xFF10B981),
                      icon: Icons.check,
                      title: "Confirm",
                      subtitle: "Open order details",
                      onTap: widget.onConfirm,
                    ),
                    const Divider(height: 1),
                    _ActionItem(
                      iconBg: const Color(0xFFFFFBEB),
                      iconColor: const Color(0xFFF59E0B),
                      icon: Icons.hourglass_bottom,
                      title: "Pending",
                      subtitle: "Do nothing",
                      onTap: widget.onPending,
                    ),
                    const Divider(height: 1),
                    _ActionItem(
                      iconBg: const Color(0xFFFEF2F2),
                      iconColor: const Color(0xFFEF4444),
                      icon: Icons.close,
                      title: "Cancel",
                      subtitle: "Delete & remove order",
                      onTap: widget.onCancel,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final Future<void> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // hand cursor
      child: InkWell(
        onTap: () async => await onTap(),
        hoverColor: const Color(0xFFF1F5F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
