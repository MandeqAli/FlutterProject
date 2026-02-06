import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/categories_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/category_item.dart';
import '../screens/cart_screen.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});

  final CategoriesController c = Get.put(CategoriesController());
  final CartController cart = Get.put(CartController()); // keep cart alive

  // your bright colors
  static const _bg = Color(0xFF8FC2D6);
  static const _card = Color(0xFF155780);
  static const _stroke = Color(0xFF286C8C);
  static const _accent = Color(0xFF00E6B0);
  static const _accent2 = Color(0xFF3AA3FF);

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
        title: const Text("Categories", style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Get.to(() => const CartScreen()),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _stroke),
                ),
                child: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Obx(() {
                if (c.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (c.error.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          c.error.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: c.fetchProducts,
                          child: const Text("Retry"),
                        )
                      ],
                    ),
                  );
                }

                return Scrollbar(
                  thumbVisibility: true,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: c.categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 185,
                    ),
                    itemBuilder: (_, i) {
                      final item = c.categories[i];
                      return _CategoryCard(
                        item: item,
                        onFav: () => c.toggleFav(item),
                        onArrow: () => c.openDetails(item),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        final idx = c.selectedTab.value;
        return Container(
          padding: const EdgeInsets.only(top: 8, bottom: 10),
          decoration: BoxDecoration(color: _bg, border: Border(top: BorderSide(color: _stroke))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_outlined, label: "Home", active: idx == 0, onTap: () => c.onTabChange(0)),
              _NavItem(icon: Icons.grid_view_rounded, label: "Categories", active: idx == 1, onTap: () => c.onTabChange(1)),
              _NavItem(
                icon: Icons.shopping_cart_outlined,
                label: "My Cart",
                active: idx == 2,
                onTap: () {
                  c.onTabChange(2);
                  Get.to(() => const CartScreen());
                },
              ),
              _NavItem(icon: Icons.person_outline_rounded, label: "Profile", active: idx == 3, onTap: () => c.onTabChange(3)),
            ],
          ),
        );
      }),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.item,
    required this.onFav,
    required this.onArrow,
  });

  final CategoryItem item;
  final VoidCallback onFav;
  final VoidCallback onArrow;

  static const _card = Color(0xFF43A177);
  static const _stroke = Color(0xFF24546B);
  static const _imgBg = Color(0xFF173B52);

  static const _accent = Color(0xFF00E6B0);
  static const _accent2 = Color(0xFF3AA3FF);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _stroke),
        boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 12, offset: Offset(0, 10))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Obx(() {
                final fav = item.isFav.value;
                return InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: onFav,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      color: fav ? const Color(0xFFFF4D6D) : Colors.white70,
                      size: 18,
                    ),
                  ),
                );
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _imgBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _stroke),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Center(
                      child: Image.network(
                        item.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.white38),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: onArrow,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(colors: [_accent2, _accent], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.active, required this.onTap});

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  static const _active = Color(0xFF00E6B0);
  static const _inactive = Colors.white70;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? _active : _inactive, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active ? _active : _inactive,
                fontSize: 11,
                fontWeight: active ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
