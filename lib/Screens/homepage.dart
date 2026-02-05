import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0D0D),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
          children: [
            _TopBar(username: username),
            const SizedBox(height: 14),
            _SearchBar(),
            const SizedBox(height: 18),

            // Hero banner (modern card look)
            _HeroCard(username: username),

            const SizedBox(height: 20),
            _SectionHeader(title: 'Our Popular Categories', actionText: 'See all'),
            const SizedBox(height: 12),
            const _CategoriesRow(),

            const SizedBox(height: 22),
            _SectionHeader(title: "Today's Best Offer", actionText: 'Browse'),
            const SizedBox(height: 12),
            const _OffersGrid(),

            const SizedBox(height: 22),
            _SectionHeader(title: 'Seasonal Exclusive Solutions', actionText: 'Explore'),
            const SizedBox(height: 12),
            const _SeasonalRow(),
          ],
        ),
      ),

      // Optional bottom nav (simple)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0C0D0D),
        selectedItemColor: const Color(0xFFFF7A00),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
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

class _TopBar extends StatelessWidget {
  final String username;
  const _TopBar({required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
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

        // Greeting
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome 👋',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 2),
              Text(
                username.isEmpty ? 'User' : username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),

        // Notifications
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

class _SearchBar extends StatelessWidget {
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
          BoxShadow(
            blurRadius: 22,
            color: Color(0x33000000),
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Text area
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pharmy Care',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Health products\nfor your lifestyle',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Personal picks for ${username.isEmpty ? "you" : username}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      elevation: 0,
                    ),
                    onPressed: () {},
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

            // Right graphic placeholder (modern)
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

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  const _SectionHeader({required this.title, required this.actionText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          actionText,
          style: const TextStyle(
            color: Color(0xFFFF7A00),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CategoriesRow extends StatelessWidget {
  const _CategoriesRow();

  @override
  Widget build(BuildContext context) {
    final items = const [
      (Icons.favorite_rounded, 'Heart'),
      (Icons.spa_rounded, 'Skincare'),
      (Icons.bloodtype_rounded, 'Diabetes'),
      (Icons.healing_rounded, 'First Aid'),
      (Icons.local_hospital_rounded, 'Wellness'),
    ];

    return SizedBox(
      height: 92,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final icon = items[i].$1;
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
                  child: Icon(icon, color: const Color(0xFFFF7A00)),
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

class _OffersGrid extends StatelessWidget {
  const _OffersGrid();

  @override
  Widget build(BuildContext context) {
    // Fake products for UI only
    final products = const [
      ('Vitamin C', '₦ 5,600', Icons.local_offer_rounded),
      ('Omega 3', '₦ 6,200', Icons.local_offer_rounded),
      ('Zinc', '₦ 4,900', Icons.local_offer_rounded),
      ('Magnesium', '₦ 7,100', Icons.local_offer_rounded),
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
              // product image placeholder
              Container(
                height: 78,
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Icon(Icons.medication_rounded, color: Colors.white70, size: 34),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              Text(price, style: const TextStyle(color: Colors.white70)),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF7A00),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text('Buy', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.favorite_border_rounded, color: Colors.white70),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _SeasonalRow extends StatelessWidget {
  const _SeasonalRow();

  @override
  Widget build(BuildContext context) {
    final cards = const [
      ('Cold & Flu', Icons.ac_unit_rounded),
      ('Skin Glow', Icons.wb_sunny_rounded),
      ('Energy', Icons.bolt_rounded),
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final title = cards[i].$1;
          final icon = cards[i].$2;
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
                  child: Icon(icon, color: const Color(0xFFFF7A00)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
