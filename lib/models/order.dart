import 'cart_item.dart';

class OrderProductItem {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;
  final String unit;
  final String shopName;

  OrderProductItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.unit,
    required this.shopName,
  });

  factory OrderProductItem.fromCartItem(CartItem item) {
    final unit = item.product.category.toLowerCase() == 'food' ? 'kg' : 'pcs';
    return OrderProductItem(
      name: item.product.name,
      imageUrl: item.product.imageUrl,
      price: item.product.price,
      quantity: item.quantity,
      unit: unit,
      shopName: item.product.shopName,
    );
  }
}

class Order {
  final String orderId;
  final DateTime date;
  final double totalAmount;
  final List<OrderProductItem> items;
  final String address;
  final String paymentMethod;
  String status;

  Order({
    required this.orderId,
    required this.date,
    required this.totalAmount,
    required this.items,
    required this.address,
    required this.paymentMethod,
    this.status = 'Menunggu Pembayaran',
  });
}
