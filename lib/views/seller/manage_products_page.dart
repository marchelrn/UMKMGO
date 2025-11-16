import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/auth_provider.dart';
import 'add_product_page.dart';

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final String sellerShopName;
    if (authProvider.currentUser?.email == 'seller@test.com') {
      sellerShopName = 'Java Crafts';
    } else {
      sellerShopName = authProvider.currentUser?.email ?? 'My Shop';
    }

    final sellerProducts = productProvider.getProductsByShop(sellerShopName);

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Products')),
      body: sellerProducts.isEmpty
          ? Center(
              child: Text(
                'You have not added any products yet.',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            )
          : ListView.builder(
              itemCount: sellerProducts.length,
              itemBuilder: (context, index) {
                final product = sellerProducts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.imageUrl),
                    onBackgroundImageError: (e, s) =>
                        const Icon(Icons.image_not_supported),
                  ),
                  title: Text(product.name),
                  subtitle: Text('Stock: ${product.stock}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Edit product (not implemented yet)',
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Are you sure?'),
                              content: Text(
                                'Do you want to delete ${product.name}?',
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () => Navigator.of(ctx).pop(),
                                ),
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    productProvider.deleteProduct(product.name);
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
