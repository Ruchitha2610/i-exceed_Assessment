import 'package:flutter/material.dart';

void main() {
  runApp(Bank());
}

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  bool showBalance = false;

  void toggleBalance() {
    setState(() {
      showBalance = !showBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Center(
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Times New Roman",
              ),
            ),
          ),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  // Background
                  Container(height: 200, color: Colors.indigo),
                  // Animated text
                  AnimatedPositioned(
                    duration: Duration(seconds: 1),
                    top: showBalance ? 20 : 60,
                    left: 20,
                    child: Text(
                      "Hi 👋 Ruchitha",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Animated avatar
                  AnimatedPositioned(
                    duration: Duration(seconds: 1),
                    left: 330,
                    top: showBalance ? 0 : 30,
                    child: CircleAvatar(radius: 35, child: Icon(Icons.person)),
                  ),
                  // Balance card
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BalanceCard(
                      showBalance: showBalance,
                      onToggle: toggleBalance,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final bool showBalance;
  final VoidCallback onToggle;

  const BalanceCard({required this.showBalance, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: showBalance ? Alignment.center : Alignment.bottomCenter,
      duration: Duration(seconds: 1),
      child: GestureDetector(
        onTap: onToggle,
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.shade300)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Account Balance', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text(
                showBalance ? '₹1,25,000' : '********',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('(Tap to ${showBalance ? 'hide' : 'show'})'),
            ],
          ),
        ),
      ),
    );
  }
}
