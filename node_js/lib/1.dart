import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AmazonProfilePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class AmazonProfilePage extends StatelessWidget {
  const AmazonProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: const Text('Your Account'),
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
                    backgroundColor: Colors.orange,
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
            _sectionHeader('Your Orders'),
            _optionTile('Track Orders', Icons.local_shipping),
            _optionTile('Buy Again', Icons.replay),
            _optionTile('Your Returns', Icons.assignment_return),

            const SizedBox(height: 10),
            _sectionHeader('Account Settings'),
            _optionTile('Login & Security', Icons.lock),
            _optionTile('Prime Membership', Icons.star),
            _optionTile('Manage Addresses', Icons.location_on),
            _optionTile('Payment Options', Icons.payment),

            const SizedBox(height: 10),
            _sectionHeader('Communication and Content'),
            _optionTile('Your Messages', Icons.message),
            _optionTile('Your Reviews', Icons.rate_review),
            _optionTile('Language Settings', Icons.language),

            const SizedBox(height: 10),
            _sectionHeader('Customer Support'),
            _optionTile('Contact Us', Icons.support_agent),
            _optionTile('Help', Icons.help_outline),

            const SizedBox(height: 10),
            _sectionHeader('Log Out'),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out'),
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
          leading: Icon(icon, color: Colors.orange[800]),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const Divider(height: 1),
      ],
    );
  }
}
