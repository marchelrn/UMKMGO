import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  // Daftar dummyProducts sekarang menjadi state internal, dikelola oleh provider.
  final List<Product> _items = [
    Product(
      name: 'Handmade Woven Bag',
      description: 'Tas anyaman buatan tangan yang cantik, cocok untuk jalan-jalan.',
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
      description: 'Sambal buatan rumah ekstra pedas, penting untuk masakan Indonesia.',
      imageUrl: 'https://placehold.co/600x400/8B0000/FFFFFF?text=Chili+Sambal',
      price: 25000,
      category: 'Food',
      shopName: 'Sambal Mama',
      stock: 100,
    ),
    Product(
      name: 'Batik Print Scarf',
      description: 'Syal katun lembut dengan motif Batik tradisional.',
      imageUrl: 'https://placehold.co/600x400/004D40/FFFFFF?text=Batik+Scarf',
      price: 75000,
      category: 'Fashion',
      shopName: 'Batik Corner',
      stock: 35,
    ),
    Product(
      name: 'Wooden Kitchen Set',
      description: 'Satu set sendok dan spatula kayu ramah lingkungan.',
      imageUrl: 'https://placehold.co/600x400/FFA500/000000?text=Wood+Utensils',
      price: 50000,
      category: 'Crafts',
      shopName: 'Kayu Indah',
      stock: 45,
    ),
    Product(
      name: 'Freshly Baked Cookies',
      description: 'Kue kering chocolate chip, dipanggang segar setiap hari.',
      imageUrl: 'https://placehold.co/600x400/795548/FFFFFF?text=Cookies',
      price: 30000,
      category: 'Food',
      shopName: 'Cookie Haven',
      stock: 60,
    ),
    Product(
      name: 'Custom Graphic T-Shirt',
      description: 'Kaos katun premium dengan desain sablon unik.',
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


    // --- 5 PRODUK BARU DITAMBAHKAN ---
    Product(
      name: 'Kopi Gayo Asli Aceh',
      description: 'Biji kopi Arabika Gayo asli dari dataran tinggi Aceh, aroma kuat dan kaya rasa.',
      imageUrl: 'https://placehold.co/600x400/6F4E37/FFFFFF?text=Kopi+Gayo',
      price: 90000,
      category: 'Food',
      shopName: 'Kopi Bintang',
      stock: 50,
    ),
    Product(
      name: 'Wayang Golek Cepot',
      description: 'Kerajinan tangan Wayang Golek khas Sunda, karakter Cepot. Cocok untuk pajangan.',
      imageUrl: 'https://placehold.co/600x400/8B4513/FFFFFF?text=Wayang+Golek',
      price: 120000,
      category: 'Crafts',
      shopName: 'Seni Sunda',
      stock: 15,
    ),
    Product(
      name: 'Kain Tenun Sumba',
      description: 'Kain tenun ikat asli Sumba, NTT. Motif tradisional yang etnik dan mewah.',
      imageUrl: 'https://placehold.co/600x400/A52A2A/FFFFFF?text=Tenun+Sumba',
      price: 750000,
      category: 'Fashion',
      shopName: 'Nusa Tenun',
      stock: 5,
    ),
    Product(
      name: 'Keripik Tempe Sagu',
      description: 'Keripik tempe renyah dibuat dengan sagu, gurih dan cocok untuk camilan.',
      imageUrl: 'https://placehold.co/600x400/D2B48C/000000?text=Keripik+Tempe',
      price: 15000,
      category: 'Food',
      shopName: 'Camilan Juara',
      stock: 150,
    ),
    Product(
      name: 'Guci Gerabah Kasongan',
      description: 'Guci keramik gerabah dari Kasongan, Yogyakarta. Desain klasik untuk dekorasi rumah.',
      imageUrl: 'https://placehold.co/600x400/CD853F/FFFFFF?text=Gerabah',
      price: 200000,
      category: 'Crafts',
      shopName: 'Lestari Gerabah',
      stock: 10,
    ),
  ];

  // Getter publik untuk daftar produk
  List<Product> get items => _items;

  // --- Fungsi CRUD Penjual ---

  // (Ini adalah contoh sederhana; aplikasi nyata akan memfilter berdasarkan ID penjual)
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

// <<< The stray text was here and has been removed.