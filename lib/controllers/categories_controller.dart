import 'package:get/get.dart';
import '../models/category_item.dart';
import '../pages/category_details_page.dart';

class CategoriesController extends GetxController {
  final RxInt selectedTab = 1.obs;

  final RxList<CategoryItem> categories = <CategoryItem>[
    CategoryItem(
      id: 1,
      title: "Ela De Pure",
      subtitle: "12 items",
      imageUrl:
      "https://images.unsplash.com/photo-1762651356493-c492ca111a07?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aGFpciUyMGNhcmUlMjBwcm9kdWN0JTIwY29sbGVjdGlvbnxlbnwwfHwwfHx8MA%3D%3D",
      description:
      "Ela De Pure hair-care collection for smoother, softer hair. Helps reduce frizz and keeps hair looking healthy with regular use.",
      priceCents: 1099,
      rating: 4.8,
      etaText: "25-35 min",
      fav: true,
    ),
    CategoryItem(
      id: 2,
      title: "Omega Three",
      subtitle: "18 items",
      imageUrl:
      "https://images.unsplash.com/photo-1662673145204-c843cb1d6ff0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c3VwcGxlbWVudCUyMG9tZWdhJTIwdGhyZWV8ZW58MHx8MHx8fDA%3D",
      description:
      "Omega Three supplement rich in essential fatty acids. Supports heart health, brain function, and joint comfort as part of a daily routine.",
      priceCents: 1299,
      rating: 4.6,
      etaText: "20-30 min",
    ),
    CategoryItem(
      id: 3,
      title: "Magnesium 7",
      subtitle: "9 items",
      imageUrl:
      "https://images.unsplash.com/photo-1649333243484-df91ff7b73ad?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFnbmVzaXVtJTIwc3VwcGxlbWVudHxlbnwwfHwwfHx8MA%3D%3D",
      description:
      "Magnesium 7 formula designed to support muscle recovery and relaxation. Commonly used for stress support and better sleep balance.",
      priceCents: 999,
      rating: 4.5,
      etaText: "15-25 min",
    ),
    CategoryItem(
      id: 4,
      title: "Zinc",
      subtitle: "10 items",
      imageUrl:
      "https://images.unsplash.com/photo-1596177583101-26b7dada4f5c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8emluYyUyMHN1cHBsZW1lbnR8ZW58MHx8MHx8fDA%3D",
      description:
      "Zinc supplement to support immune defense and healthy skin. Often used to maintain overall wellness and daily nutritional balance.",
      priceCents: 999,
      rating: 4.7,
      etaText: "25-40 min",
      fav: true,
    ),
    CategoryItem(
      id: 5,
      title: "Vitamins",
      subtitle: "14 items",
      imageUrl:
      "https://images.unsplash.com/photo-1586015555751-63bb77f4322a?w=900",
      description:
      "Everyday vitamins and multivitamins for energy and nutrition support. Ideal for filling common diet gaps.",
      priceCents: 1299,
      rating: 4.4,
      etaText: "20-35 min",
    ),
    CategoryItem(
      id: 6,
      title: "Sunday",
      subtitle: "20 items",
      imageUrl:
      "https://images.unsplash.com/photo-1624939461078-66a124b3539c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aGFpciUyMGNhcmUlMjBwcm9kdWN0fGVufDB8fDB8fHww",
      description:
      "Sunday hair products made for weekly care routines. Helps nourish dry hair and improve shine with consistent use.",
      priceCents: 899,
      rating: 4.3,
      etaText: "15-30 min",
    ),

    CategoryItem(
      id: 7,
      title: "Sunscreen",
      subtitle: "8 items",
      imageUrl:
      "https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=900",
      description:
      "Daily sunscreen for UVA/UVB protection. Helps prevent sun damage, dark spots, and early aging—reapply during the day.",
      priceCents: 1099,
      rating: 4.7,
      etaText: "20-30 min",
    ),
    CategoryItem(
      id: 8,
      title: "Paula's Choice",
      subtitle: "6 items",
      imageUrl:
      "https://images.unsplash.com/photo-1620159074233-08bed39ebc6a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTI0fHxoYWlyJTIwY2FyZSUyMHByb2R1Y3QlMjBjb2xsZWN0aW9ufGVufDB8fDB8fHww",
      description:
      "Paula's Choice skincare essentials focused on clearer skin. Popular for exfoliants and barrier-friendly routines.",
      priceCents: 1399,
      rating: 4.6,
      etaText: "25-40 min",
    ),
    CategoryItem(
      id: 9,
      title: "Ordinary",
      subtitle: "11 items",
      imageUrl:
      "https://images.unsplash.com/photo-1580870069867-74c57ee1bb07?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2tpbmNhcmUlMjBwcm9kdWN0c3xlbnwwfHwwfHx8MA%3D%3D",
      description:
      "The Ordinary formulas for targeted skincare needs. Great for hydration, brightening, and improving skin texture over time.",
      priceCents: 899,
      rating: 4.5,
      etaText: "20-35 min",
    ),
    CategoryItem(
      id: 10,
      title: "Moisturizer",
      subtitle: "13 items",
      imageUrl:
      "https://images.unsplash.com/photo-1564594326930-17381130fd2e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzN8fE1vaXN0dXJpemVyJTIwcHJvZHVjdHN8ZW58MHx8MHx8fDA%3D",
      description:
      "Moisturizers that lock hydration and keep skin soft. Supports barrier protection, especially for dry or sensitive skin.",
      priceCents: 1199,
      rating: 4.6,
      etaText: "20-35 min",
    ),
    CategoryItem(
      id: 11,
      title: "Serums",
      subtitle: "7 items",
      imageUrl:
      "https://images.unsplash.com/photo-1629380150561-5fe77dab7fc6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHNlcnVtcyUyMHByb2R1Y3RzfGVufDB8fDB8fHww",
      description:
      "Concentrated serums for specific skin goals like glow, hydration, and fading uneven tone. Use before moisturizer.",
      priceCents: 1299,
      rating: 4.7,
      etaText: "25-45 min",
    ),
    CategoryItem(
      id: 12,
      title: "First Aid",
      subtitle: "5 items",
      imageUrl:
      "https://images.unsplash.com/photo-1563260324-5ebeedc8af7c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Zmlyc3QlMjBhaWQlMjBraXR8ZW58MHx8MHx8fDA%3D",
      description:
      "First aid essentials for quick home care: antiseptics, plasters, gauze, and basic protection items.",
      priceCents: 1299,
      rating: 4.4,
      etaText: "15-30 min",
    ),
  ].obs;

  void toggleFav(CategoryItem item) => item.isFav.value = !item.isFav.value;

  void openDetails(CategoryItem item) {
    Get.to(() => CategoryDetailsPage(item: item));
  }

  void onTabChange(int index) => selectedTab.value = index;
}
