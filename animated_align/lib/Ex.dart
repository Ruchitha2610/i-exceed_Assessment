import 'package:flutter/material.dart';

void main() {
  runApp(Bank());
}

class Bank extends StatelessWidget {
  const Bank({super.key});

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
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    color: Colors.indigo,
                    padding: EdgeInsets.only(left: 20, bottom: 85),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hi 👋 Ruchitha",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 330,
                    top: 30,
                    child: CircleAvatar(radius: 35, child: Icon(Icons.person)),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BalanceCard(), // Your animated balance card
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

class BalanceCard extends StatefulWidget {
  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool showBalance = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: showBalance ? Alignment.center : Alignment.bottomCenter,
      duration: Duration(seconds: 1),
      child: GestureDetector(
        onTap: () {
          setState(() {
            showBalance = !showBalance;
          });
        },
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
