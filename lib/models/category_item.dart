import 'package:get/get.dart';

class CategoryItem {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  final String description;
  final int priceCents;
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

  String get priceText => "\$${(priceCents / 100).toStringAsFixed(2)}";

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: (json["id"] ?? 0) is int ? json["id"] : int.tryParse("${json["id"]}") ?? 0,
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      imageUrl: json["imageUrl"] ?? "",
      description: json["description"] ?? "",
      priceCents: (json["priceCents"] ?? 0) is int
          ? json["priceCents"]
          : int.tryParse("${json["priceCents"]}") ?? 0,
      rating: (json["rating"] is num) ? (json["rating"] as num).toDouble() : 0.0,
      etaText: json["etaText"] ?? "",
      fav: json["fav"] == true,
    );
  }
}
