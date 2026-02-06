import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/categories_page.dart';
import '../controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // ✅ Get the AuthController
  final AuthController auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 32, 45),
      body: SafeArea(
        child: Obx(() {
          // ✅ FIX: use currentUserName (not currentUser)
          final username = auth.currentUserName.value;

          return ListView(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
            children: [
              _TopBar(username: username),
              const SizedBox(height: 14),
              const _SearchBar(),
              const SizedBox(height: 18),
              _HeroCard(username: username),
              const SizedBox(height: 20),
              const _SectionHeader(title: 'Our Popular Categories', actionText: 'See all'),
              const SizedBox(height: 12),
              const _CategoriesRow(),
              const SizedBox(height: 22),
              const _SectionHeader(title: "Today's Best Offer", actionText: 'Browse'),
              const SizedBox(height: 12),
              const _OffersGrid(),
              const SizedBox(height: 22),
              const _SectionHeader(title: 'Seasonal Exclusive Solutions', actionText: 'Explore'),
              const SizedBox(height: 12),
              const _SeasonalRow(),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 186, 189, 190),
        selectedItemColor: const Color.fromARGB(255, 4, 39, 61),
        unselectedItemColor: const Color.fromARGB(136, 252, 251, 251),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Get.to(() => CategoriesPage());
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer_rounded), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

// ================== Top Bar ==================
class _TopBar extends StatelessWidget {
  final String username;
  const _TopBar({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white70),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome 👋', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 2),
              Text(
                username.isEmpty ? 'User' : username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: const Icon(Icons.notifications_rounded, color: Colors.white70),
        ),
      ],
    );
  }
}

// ================== Search Bar ==================
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, color: Colors.white54),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search medicines, vitamins, skincare...',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ),
          Icon(Icons.tune_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}

// ================== Hero Card ==================
class _HeroCard extends StatelessWidget {
  final String username;
  const _HeroCard({required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF7A00), Color(0xFFFFC107)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(blurRadius: 22, color: Color(0x33000000), offset: Offset(0, 12))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pharmy Care', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  const Text(
                    'Health products\nfor your lifestyle',
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w900, height: 1.1),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Personal picks for ${username.isEmpty ? "you" : username}',
                    style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      elevation: 0,
                    ),
                    onPressed: () => Get.toNamed('/categories'),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Shop now', style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 92,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white30),
              ),
              child: const Icon(Icons.medication_rounded, color: Colors.black87, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== Section Header ==================
class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  const _SectionHeader({required this.title, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16.5, fontWeight: FontWeight.w800))),
        Text(actionText, style: const TextStyle(color: Color(0xFFFF7A00), fontWeight: FontWeight.w700)),
      ],
    );
  }
}

// ================== Categories Row ==================
class _CategoriesRow extends StatelessWidget {
  const _CategoriesRow();

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('https://img.icons8.com/color/96/000000/like.png', 'Heart'),
      ('https://img.icons8.com/color/96/000000/spa.png', 'Skincare'),
      ('https://img.icons8.com/color/96/000000/blood-type.png', 'Diabetes'),
      ('https://img.icons8.com/color/96/000000/first-aid-kit.png', 'First Aid'),
      ('https://img.icons8.com/color/96/000000/hospital-room.png', 'Wellness'),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final imageUrl = items[i].$1;
          final text = items[i].$2;
          return Container(
            width: 92,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0x22FF7A00),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(height: 8),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ================== Offers Grid ==================
class _OffersGrid extends StatelessWidget {
  const _OffersGrid();

  @override
  Widget build(BuildContext context) {
    final products = const [
      ('Vitamin C', '₦ 5,600', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhtoiHmXU8F1DzcIB3HlmkUivdIvt2V_c60g&s'),
      ('Omega 3', '₦ 6,200', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNiJauF_-UYY2atUTmI8KwKfijE6bNE5SW-g&s'),
      ('Zinc', '₦ 4,900', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5tbJ_S_wYueEloLhr59Qgv9KVkda1qrrFKw&s'),
      ('Magnesium', '₦ 7,100', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiIfZUU5MXZiU3JS8DxvPLhxPs-XANw38eeg&s'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, i) {
        final name = products[i].$1;
        final price = products[i].$2;
        final imageUrl = products[i].$3;

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(price, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        );
      },
    );
  }
}

// ================== Seasonal Row ==================
class _SeasonalRow extends StatelessWidget {
  const _SeasonalRow();

  @override
  Widget build(BuildContext context) {
    final cards = const [
      ('Cold & Flu', 'https://img.icons8.com/color/96/000000/cold.png'),
      ('Skin Glow', 'https://www.mederma.co.in/wp-content/uploads/2024/11/How-to-make-Skin-glow-naturally.jpg'),
      ('Energy', 'https://watchwire.ai/wp-content/uploads/2021/06/renewable_energy_sources-e1551858601606.jpg'),
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final title = cards[i].$1;
          final imageUrl = cards[i].$2;
          return Container(
            width: 150,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0x22FF7A00),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
