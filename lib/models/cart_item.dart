import 'product.dart';

class CartItem {
  final Product product;
  int quantity;
  final String notes;

  CartItem({required this.product, required this.quantity, this.notes = ''});
}
