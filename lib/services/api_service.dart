import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com';

  static Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse('$_baseUrl/products'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Failed to load products');
  }
}
