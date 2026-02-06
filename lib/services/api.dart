import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // ✅ Android Emulator uses 10.0.2.2
  static const baseUrl = 'http://localhost:5000/api';

  static Future<dynamic> get(String path) async {
    final res = await http.get(Uri.parse("$baseUrl$path"));
    if (res.statusCode >= 200 && res.statusCode < 300)
      return jsonDecode(res.body);
    throw Exception("GET $path failed: ${res.body}");
  }

  static Future<dynamic> post(String path, dynamic body) async {
    final res = await http.post(
      Uri.parse("$baseUrl$path"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    if (res.statusCode >= 200 && res.statusCode < 300)
      return jsonDecode(res.body);
    throw Exception("POST $path failed: ${res.body}");
  }
}
