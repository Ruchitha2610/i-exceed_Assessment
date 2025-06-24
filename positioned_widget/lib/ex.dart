import 'package:flutter/material.dart';

void main() {
  runApp(MyBankHomePage());
}

class MyBankHomePage extends StatelessWidget {
  const MyBankHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank Home',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text(
            'ICICI Bank',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            // Top Search and Login Section
            Container(
              color: Colors.orange.shade50,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search, color: Colors.black),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Search for Products, Services...",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  Icon(Icons.login, color: Colors.deepOrange),
                ],
              ),
            ),

            // Banner Section
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Save Tax Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Invest in ICICI Tax Saver FD\nUp to ₹46,800* exemption",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            // Offers Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: buildOfferCard("Credit Card", "Get your card now"),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: buildOfferCard("Personal Loan", "Up to ₹50 lakh"),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: buildOfferCard("Car Loan", "Drive your dream car"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Investment Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: buildOfferCard("Fixed Deposit", "Safe & Secure"),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: buildOfferCard("Mutual Fund", "Grow your wealth"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Services Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 2,
                child: ListTile(
                  title: Text("Track Applications / Service Requests"),
                  subtitle: Text("Check your requests easily"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Card
  Widget buildOfferCard(String title, String subtitle) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(12),
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(subtitle, style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
