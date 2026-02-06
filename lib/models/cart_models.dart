class CartItemModel {
  final int productId;
  final String title;
  final String imageUrl;
  final int priceCents;
  final int qty;

  CartItemModel({
    required this.productId,
    required this.title,
    required this.imageUrl,
    required this.priceCents,
    required this.qty,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> j) {
    return CartItemModel(
      productId: j["productId"],
      title: j["title"],
      imageUrl: j["imageUrl"],
      priceCents: j["priceCents"],
      qty: j["qty"],
    );
  }

  String get priceText => "\$${(priceCents / 100).toStringAsFixed(2)}";
  String get lineTotalText => "\$${((priceCents * qty) / 100).toStringAsFixed(2)}";
}
