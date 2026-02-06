import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // ✅ Your backend
  static const String baseUrl = "http://localhost:5000";

  static Future<Map<String, dynamic>> get(String path) async {
    final uri = Uri.parse("$baseUrl$path");
    final res = await http.get(uri);

    final body = res.body.isNotEmpty ? jsonDecode(res.body) : {};
    if (res.statusCode >= 400) {
      throw Exception(body["message"] ?? "Request failed (${res.statusCode})");
    }
    return (body is Map<String, dynamic>) ? body : {};
  }

  static Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> data,
  ) async {
    final uri = Uri.parse("$baseUrl$path");
    final res = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    final body = res.body.isNotEmpty ? jsonDecode(res.body) : {};
    if (res.statusCode >= 400) {
      throw Exception(body["message"] ?? "Request failed (${res.statusCode})");
    }
    return (body is Map<String, dynamic>) ? body : {};
  }
}
