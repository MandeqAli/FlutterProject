class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int points;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      points: json['points'] ?? 0,
    );
  }
}
