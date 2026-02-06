import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profileUserModel.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api/user'; 
  // Use 10.0.2.2 for Android emulator; use your PC IP if testing on real device

  // Get User
  static Future<User?> getUser(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    }
    return null;
  }

  // Update User
  static Future<User?> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    }
    return null;
  }
}
