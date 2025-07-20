// lib/providers/product_provider.dart

import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../utils/shared_prefs.dart';

/// Extended sort options.
enum SortOption {
  priceLowHigh,
  priceHighLow,
  ratingLowHigh,
  ratingHighLow,
}

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get allProducts => _products;

  List<String> _favs = SharedPrefs.getFavourites() ?? [];
  List<String> get favs => _favs;

  bool _loading = false;
  bool get loading => _loading;

  String?     _selectedCategory;
  SortOption? _sortOption;
  double      _maxPriceFilter = double.infinity;
  String      _searchQuery    = '';

  String?     get selectedCategory => _selectedCategory;
  SortOption? get sortOption       => _sortOption;
  double      get maxPriceFilter   => _maxPriceFilter;
  String      get searchQuery      => _searchQuery;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _loading = true;
    notifyListeners();

    _products = await ApiService.fetchProducts();

    // reset all filters & search
    _selectedCategory = null;
    _sortOption       = null;
    _maxPriceFilter   = double.infinity;
    _searchQuery      = '';

    _loading = false;
    notifyListeners();
  }

  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList()..sort();
    return ['All', ...cats];
  }

  /// Filter by category (null or 'All' = no filter).
  void selectCategory(String? category) {
    _selectedCategory =
        (category == null || category == 'All') ? null : category;
    notifyListeners();
  }

  /// Filter by maximum price.
  void setMaxPriceFilter(double maxPrice) {
    _maxPriceFilter = maxPrice;
    notifyListeners();
  }

  /// Sort products list in place.
  void sort(SortOption option) {
    _sortOption = option;
    switch (option) {
      case SortOption.priceLowHigh:
        _products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighLow:
        _products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.ratingLowHigh:
        _products.sort((a, b) => a.rating.compareTo(b.rating));
        break;
      case SortOption.ratingHighLow:
        _products.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    notifyListeners();
  }

  /// Update search query and rebuild filters.
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Combined filtered list: category, price, search.
  List<Product> get filteredProducts {
    return _products.where((p) {
      if (_selectedCategory != null && p.category != _selectedCategory) {
        return false;
      }
      if (p.price > _maxPriceFilter) {
        return false;
      }
      if (_searchQuery.isNotEmpty &&
          !p.title.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Favorite toggle.
  void toggleFavourite(String id) {
    if (_favs.contains(id)) {
      _favs.remove(id);
    } else {
      _favs.add(id);
    }
    SharedPrefs.setFavourites(_favs);
    notifyListeners();
  }

  bool isFavourite(String id) => _favs.contains(id);
}
