// lib/models/category_item.dart
import 'package:get/get.dart';

class CategoryItem {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  // extra details for the details page
  final String description;
  final int priceCents; // just for demo
  final double rating;
  final String etaText;

  final RxBool isFav;

  CategoryItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.description,
    required this.priceCents,
    required this.rating,
    required this.etaText,
    bool fav = false,
  }) : isFav = fav.obs;

  String get priceText {
    final v = priceCents / 100.0;
    return "\$${v.toStringAsFixed(2)}";
  }
}
