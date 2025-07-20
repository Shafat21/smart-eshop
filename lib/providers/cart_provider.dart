import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;
  int get count => _items.length;
  double get total => _items.fold(0, (sum, item) => sum + item.price);

  void add(Product p) {
    _items.add(p);
    notifyListeners();
  }

  void remove(Product p) {
    _items.remove(p);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
