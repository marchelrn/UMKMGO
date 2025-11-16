import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umkmgo/providers/theme_provider.dart';
import 'package:umkmgo/providers/order_provider.dart';
import 'package:umkmgo/providers/auth_provider.dart';
import 'package:umkmgo/views/seller/seller_dashboard.dart';
import 'package:umkmgo/views/seller/manage_products_page.dart';
import 'package:umkmgo/views/seller/view_orders_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Siti Aminah',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'siti.aminah@email.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '0812-3456-7890',
  );
  final _formKey = GlobalKey<FormState>();

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved! Name: ${_nameController.text}')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), elevation: 0.5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 60),
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField('Nama Lengkap', _nameController, Icons.person),
              _buildTextField(
                'Email',
                _emailController,
                Icons.email,
                readOnly: true,
              ),
              _buildTextField(
                'Nomor Telepon',
                _phoneController,
                Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: readOnly,
          fillColor: readOnly ? Theme.of(context).cardColor : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Bidang ini tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }
}

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  String _formatRupiah(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderProvider>(context);
    final orders = orderModel.pastOrders;

    return Scaffold(
      appBar: AppBar(title: const Text('Purchase History')),
      body: orders.isEmpty
          ? Center(
              child: Text(
                'Anda belum memiliki riwayat pesanan.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.orderId,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  color: Colors.green.shade700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(
                          'Tanggal: ${_formatDate(order.date)}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Total: ${_formatRupiah(order.totalAmount)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${order.items.length} jenis barang dari ${order.items.map((e) => e.shopName).toSet().length} toko',
                          style: const TextStyle(fontSize: 14),
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

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      body: const Center(
        child: Text('List of saved cards/accounts goes here.'),
      ),
    );
  }
}

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: const Center(
        child: Text('Toggles for various notification types.'),
      ),
    );
  }
}

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language Settings')),
      body: const Center(child: Text('Option to change app language.')),
    );
  }
}
// ----------------------------------------------------

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final themeModel = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final userRole = authProvider.userRole;

    List<Widget> profileSections = [];
    if (userRole == UserRole.seller) {
      profileSections.addAll(_buildShopManagementSection(context));
    }

    if (userRole == UserRole.buyer || userRole == UserRole.seller) {
      profileSections.addAll(_buildAccountSection(context));
    }

    profileSections.addAll(
      _buildSettingsSection(context, primaryColor, themeModel),
    );
    profileSections.addAll(_buildSupportSection(context));

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(context, primaryColor, authProvider),

            if (userRole == UserRole.buyer)
              _buildBecomeSellerButton(context, authProvider),

            const SizedBox(height: 30),
            ...profileSections,
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    authProvider.logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Log Out'),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
    BuildContext context,
    Color primaryColor,
    AuthProvider authProvider,
  ) {
    final userRole = authProvider.userRole;
    final userEmail = authProvider.currentUser?.email ?? 'No Email';

    final String userName = (userRole == UserRole.seller)
        ? 'Seller Account'
        : 'Buyer Account';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).cardColor,
                child: Icon(
                  (userRole == UserRole.seller)
                      ? Icons.storefront
                      : Icons.person,
                  size: 50,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: primaryColor,
                side: BorderSide(color: primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('View/Edit Profile'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBecomeSellerButton(
    BuildContext context,
    AuthProvider authProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            authProvider.upgradeToSeller();
            _showSnackbar(context, 'Account upgraded to Seller!');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text('Become a Seller'),
        ),
      ),
    );
  }

  List<Widget> _buildShopManagementSection(BuildContext context) {
    return [
      _buildSectionHeader(context, 'SHOP MANAGEMENT'),
      _buildListItem(
        context,
        Icons.storefront,
        'My Shop / Dashboard',
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SellerDashboardPage()),
        ),
      ),
      _buildListItem(
        context,
        Icons.inventory_2_outlined,
        'Manage Products',
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ManageProductsPage()),
        ),
      ),
      _buildListItem(
        context,
        Icons.receipt_long,
        'View Orders',
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewOrdersPage()),
        ),
      ),
    ];
  }

  List<Widget> _buildAccountSection(BuildContext context) {
    return [
      _buildSectionHeader(context, 'ACCOUNT'),
      _buildListItem(
        context,
        Icons.history,
        'Purchase History',
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PurchaseHistoryPage()),
        ),
      ),
      _buildListItem(context, Icons.credit_card, 'Payment Methods', () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PaymentMethodsPage()),
        );
      }),
    ];
  }

  List<Widget> _buildSettingsSection(
    BuildContext context,
    Color primaryColor,
    ThemeProvider themeModel,
  ) {
    return [
      _buildSectionHeader(context, 'SETTINGS'),
      _buildToggleItem(
        context,
        Icons.dark_mode_outlined,
        'Dark Mode',
        themeModel.isDarkMode,
        primaryColor,
        (newValue) {
          themeModel.setDarkMode(newValue);
          _showSnackbar(
            context,
            'Dark Mode: ${newValue ? 'Enabled' : 'Disabled'}',
          );
        },
      ),
      _buildListItem(context, Icons.notifications_none, 'Notifications', () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationSettingsPage(),
          ),
        );
      }),
      _buildListItem(context, Icons.language, 'Language', () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LanguageSettingsPage()),
        );
      }),
    ];
  }

  List<Widget> _buildSupportSection(BuildContext context) {
    return [
      _buildSectionHeader(context, 'SUPPORT'),
      _buildListItem(context, Icons.help_outline, 'Help Center', () {
        _showSnackbar(context, 'Navigating to Help Center...');
      }),
      _buildListItem(context, Icons.engineering, 'Terms of Service', () {
        _showSnackbar(context, 'Navigating to Terms...');
      }),
    ];
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.labelMedium?.color,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildToggleItem(
    BuildContext context,
    IconData icon,
    String title,
    bool value,
    Color activeColor,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: activeColor,
      ),
      onTap: () {
        onChanged(!value);
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
