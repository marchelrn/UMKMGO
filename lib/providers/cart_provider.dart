import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get subtotal {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  int get totalQuantity {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  CartItem? _findItem(Product product) {
    try {
      return _items.firstWhere((item) => item.product.name == product.name);
    } catch (e) {
      return null;
    }
  }

  void addToCart(Product product, {int quantity = 1}) {
    final existingItem = _findItem(product);

    if (existingItem != null) {
      existingItem.quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    final item = _findItem(product);
    if (item != null) {
      item.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(Product product) {
    final item = _findItem(product);
    if (item != null) {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _items.remove(item);
      }
      notifyListeners();
    }
  }

  void removeItem(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
