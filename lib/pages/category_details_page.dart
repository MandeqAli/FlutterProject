import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/category_item.dart';
import '../screens/cart_screen.dart';

class CategoryDetailsController extends GetxController {
  final RxInt qty = 1.obs;

  final RxList<_AddonOption> options = <_AddonOption>[
    _AddonOption(title: "Add Vitamin C", priceCents: 50, checked: true),
    _AddonOption(title: "Add Zinc", priceCents: 60, checked: false),
    _AddonOption(title: "Add Omega 3", priceCents: 200, checked: false),
  ].obs;

  void inc() => qty.value++;
  void dec() {
    if (qty.value > 1) qty.value--;
  }

  void toggleOption(int i) => options[i].checked.value = !options[i].checked.value;

  int addonsTotalCents() {
    int sum = 0;
    for (final o in options) {
      if (o.checked.value) sum += o.priceCents;
    }
    return sum;
  }
}

class CategoryDetailsPage extends StatelessWidget {
  CategoryDetailsPage({super.key, required this.item});

  final CategoryItem item;

  final CategoryDetailsController dc =
  Get.put(CategoryDetailsController(), tag: UniqueKey().toString());

  final CartController cart = Get.find<CartController>();

  static const _bg = Color(0xFF033451);
  static const _card = Color(0xFF123247);
  static const _stroke = Color(0xFF24546B);
  static const _accentOrange = Color(0xFFFF8A2A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text("Item details", style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Obx(() {
              final fav = item.isFav.value;
              return InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: () => item.isFav.value = !item.isFav.value,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    fav ? Icons.favorite : Icons.favorite_border,
                    color: fav ? Colors.redAccent : Colors.white70,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: _card,
                          alignment: Alignment.center,
                          child: const Icon(Icons.image_not_supported, color: Colors.white38),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    item.title,
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _InfoChip(icon: Icons.local_offer_outlined, text: item.priceText),
                      _InfoChip(icon: Icons.star_rounded, text: item.rating.toStringAsFixed(1)),
                      _InfoChip(icon: Icons.access_time_rounded, text: item.etaText),
                    ],
                  ),

                  const SizedBox(height: 14),
                  const Text("Description", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(item.description, style: const TextStyle(color: Colors.white70, height: 1.35)),

                  const SizedBox(height: 16),
                  const Text("Additional options", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),

                  Obx(() {
                    return Column(
                      children: List.generate(dc.options.length, (i) {
                        final o = dc.options[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: _card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _stroke),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  o.title,
                                  style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
                                ),
                              ),
                              Text("+ \$${(o.priceCents / 100).toStringAsFixed(2)}",
                                  style: const TextStyle(color: Colors.white70)),
                              const SizedBox(width: 10),
                              Obx(() {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () => dc.toggleOption(i),
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: o.checked.value ? _accentOrange : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: _stroke),
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      size: 16,
                                      color: o.checked.value ? Colors.white : Colors.transparent,
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
        decoration: BoxDecoration(color: _bg, border: Border(top: BorderSide(color: _stroke))),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              Expanded(
                child: Obx(() {
                  final qty = dc.qty.value;
                  final totalCents = (item.priceCents + dc.addonsTotalCents()) * qty;
                  final totalText = "\$${(totalCents / 100).toStringAsFixed(2)}";
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Total price", style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 6),
                      Text(totalText,
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
                    ],
                  );
                }),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _stroke),
                ),
                child: Obx(() {
                  return Row(
                    children: [
                      _QtyBtn(icon: Icons.remove, onTap: dc.dec),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("${dc.qty.value}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                      ),
                      _QtyBtn(icon: Icons.add, onTap: dc.inc),
                    ],
                  );
                }),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: SizedBox(
                  height: 46,
                  child: Obx(() {
                    final busy = cart.loading.value;
                    return ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _accentOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      // inside CategoryDetailsPage button onPressed:
                      onPressed: busy
                          ? null
                          : () async {
                        await cart.addToCart(item.id, dc.qty.value);
                        await cart.fetchCart();
                        Get.off(() => const CartScreen()); // ✅ go to cart
                      },

                      icon: busy
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.shopping_cart_outlined, color: Colors.white),
                      label: Text(busy ? "Adding..." : "Add to cart",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.text});
  final IconData icon;
  final String text;

  static const _card = Color(0xFF123247);
  static const _stroke = Color(0xFF24546B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(14), border: Border.all(color: _stroke)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white70),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  static const _stroke = Color(0xFF24546B);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: _stroke)),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
}

class _AddonOption {
  final String title;
  final int priceCents;
  final RxBool checked;

  _AddonOption({required this.title, required this.priceCents, bool checked = false}) : checked = checked.obs;
}
