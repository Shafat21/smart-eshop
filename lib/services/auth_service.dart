import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<String?> login(String username, String password) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['token'];
    }
    return null;
  }

  static Future<bool> register({
    required String name,
    required String address,
    required String phone,
    required String email,
    required String username,
    required String password,
  }) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'address': address,
        'phone': phone,
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }
}
