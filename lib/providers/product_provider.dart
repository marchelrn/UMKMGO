import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _items = [
    Product(
      name: 'Handmade Woven Bag',
      description: 'Beautifully crafted woven bag, perfect for summer outings.',
      imageUrl: 'https://placehold.co/600x400/D2B48C/FFFFFF?text=Woven+Bag',
      price: 150000,
      category: 'Crafts',
      shopName: 'Java Crafts',
      stock: 20,
    ),
    Product(
      name: 'Spicy Chili Sambal',
      description:
          'Extra spicy homemade sambal, essential for Indonesian cuisine.',
      imageUrl: 'https://placehold.co/600x400/8B0000/FFFFFF?text=Chili+Sambal',
      price: 25000,
      category: 'Food',
      shopName: 'Sambal Mama',
      stock: 100,
    ),
    Product(
      name: 'Batik Print Scarf',
      description: 'Soft cotton scarf with traditional Batik patterns.',
      imageUrl: 'https://placehold.co/600x400/004D40/FFFFFF?text=Batik+Scarf',
      price: 75000,
      category: 'Fashion',
      shopName: 'Batik Corner',
      stock: 35,
    ),
    Product(
      name: 'Wooden Kitchen Set',
      description: 'Set of eco-friendly wooden spoons and spatulas.',
      imageUrl: 'https://placehold.co/600x400/FFA500/000000?text=Wood+Utensils',
      price: 50000,
      category: 'Crafts',
      shopName: 'Kayu Indah',
      stock: 45,
    ),
    Product(
      name: 'Freshly Baked Cookies',
      description: 'Chocolate chip cookies, baked fresh daily.',
      imageUrl: 'https://placehold.co/600x400/795548/FFFFFF?text=Cookies',
      price: 30000,
      category: 'Food',
      shopName: 'Cookie Haven',
      stock: 60,
    ),
    Product(
      name: 'Custom Graphic T-Shirt',
      description: 'Premium cotton t-shirt with a unique custom print design.',
      imageUrl: 'https://placehold.co/600x400/6A5ACD/FFFFFF?text=Graphic+Tee',
      price: 120000,
      category: 'Fashion',
      shopName: 'Creative Tees',
      stock: 50,
    ),
    Product(
      name: 'Rendang Daging Sapi',
      description:
          'Masakan daging kaya rempah khas Minangkabau, dimasak dalam santan hingga kering dan empuk.',
      imageUrl: 'https://placehold.co/600x400/B22222/FFFFFF?text=Rendang',
      price: 85000,
      category: 'Food',
      shopName: 'Warung Padang Jaya',
      stock: 30,
    ),
    Product(
      name: 'Topeng Kayu Ukir Bali',
      description:
          'Topeng tradisional Bali yang diukir dengan tangan, menampilkan detail seni budaya yang halus.',
      imageUrl: 'https://placehold.co/600x400/5D4037/FFFFFF?text=Topeng+Bali',
      price: 350000,
      category: 'Crafts',
      shopName: 'Seni Ukir Dewata',
      stock: 10,
    ),
  ];

  List<Product> get items => _items;

  List<Product> getProductsByShop(String shopName) {
    return _items.where((product) => product.shopName == shopName).toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(String productName, Product newProduct) {
    final index = _items.indexWhere((product) => product.name == productName);
    if (index != -1) {
      _items[index] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String productName) {
    _items.removeWhere((product) => product.name == productName);
    notifyListeners();
  }
}
