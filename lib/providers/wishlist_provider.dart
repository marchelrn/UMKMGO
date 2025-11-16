import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistProvider extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  bool isFavorite(Product product) {
    return _items.any((item) => item.name == product.name);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _items.removeWhere((item) => item.name == product.name);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }
}
