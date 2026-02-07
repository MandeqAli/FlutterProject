import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profileUserModel.dart';

class ApiService {
  static const baseUrl = "http://localhost:5001/api/user";

  static Future<User?> getProfile() async {
    final res = await http.get(Uri.parse("$baseUrl/profile"));

    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    }
    return null;
  }
}
