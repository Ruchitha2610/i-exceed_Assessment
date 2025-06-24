import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: FlipkartProfilePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class FlipkartProfilePage extends StatelessWidget {
  const FlipkartProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Ruchitha N',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('ruchitha@example.com'),
                      Text('+91 98765 43210'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                childAspectRatio: 1,
                padding: const EdgeInsets.all(10),
                children: const [
                  _ProfileIcon(icon: Icons.shopping_bag, label: 'Orders'),
                  _ProfileIcon(icon: Icons.favorite, label: 'Wishlist'),
                  _ProfileIcon(icon: Icons.card_giftcard, label: 'Coupons'),
                  _ProfileIcon(icon: Icons.wallet, label: 'SuperCoins'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _sectionHeader('Account Settings'),
            _optionTile('Saved Cards & Wallet', Icons.credit_card),
            _optionTile('Saved Addresses', Icons.location_on),
            _optionTile('Language Preferences', Icons.language),
            const SizedBox(height: 10),
            _sectionHeader('Support'),
            _optionTile('Help Center', Icons.help_outline),
            _optionTile('Legal & Policies', Icons.policy),
            const SizedBox(height: 10),
            _sectionHeader('Log Out'),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[300],
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _optionTile(String title, IconData icon) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blue[700]),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const Divider(height: 1),
      ],
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ProfileIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Icon(icon, color: Colors.blue[800]),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
