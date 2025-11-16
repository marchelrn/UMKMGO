import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/order_provider.dart';
import '../../models/order.dart';

class ViewOrdersPage extends StatelessWidget {
  ViewOrdersPage({super.key});

  final List<String> _orderStatuses = [
    'Menunggu Pembayaran',
    'Diproses',
    'Dikirim',
    'Selesai',
    'Dibatalkan',
  ];

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _showStatusUpdateDialog(BuildContext context, Order order) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Update Status: ${order.orderId}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _orderStatuses.map((status) {
              return ListTile(
                title: Text(status),
                trailing: order.status == status
                    ? const Icon(Icons.check, color: Colors.green)
                    : null,
                onTap: () {
                  orderProvider.updateOrderStatus(order.orderId, status);
                  Navigator.of(dialogContext).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderProvider>(context);
    final orders = orderModel.pastOrders;

    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Orders')),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'You have no incoming orders.',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                Color statusColor = Colors.green;
                if (order.status == 'Menunggu Pembayaran') {
                  statusColor = Colors.orange;
                } else if (order.status == 'Dibatalkan') {
                  statusColor = Colors.red;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.orderId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Divider(),
                        Text('Date: ${_formatDate(order.date)}'),
                        Text('Total: ${_formatRupiah(order.totalAmount)}'),
                        Text(
                          'Status: ${order.status}',
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _showStatusUpdateDialog(context, order);
                          },
                          child: const Text('Update Status'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
