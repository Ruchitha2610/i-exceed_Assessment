import 'package:flutter/material.dart';

void main() {
  runApp(Example_2());
}

class Example_2 extends StatelessWidget {
  const Example_2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(
            "Positioned widget ex2",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Stack(
          //clipBehavior: Clip.hardEdge,
          children: [
            Container(
              height: 250.0,
              width: 350.0,
              color: Colors.black,
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            ),
            Positioned(
              height: 100.0,
              width: 100.0,
              left: 50.0,
              top: 60.0,
              child: Container(
                child: Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg',
                  ),
                ),
              ),
            ),
            Positioned(
              height: 30.0,
              width: 100.0,
              left: 50.0,
              top: 180.0,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    "Anjali",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times New Roman',
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 200.0,
              top: 50.0,
              child: Container(
                height: 210.0,
                width: 150.0,
                color: Colors.white,
                child: RichText(
                  text: TextSpan(
                    text: "Summary \n",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    children: [
                      TextSpan(
                        text: '🛒 Groceries    ₹500  ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '💳 EMI Paid     ₹2,000   ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '💰 Salary       ₹25,000   ',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
