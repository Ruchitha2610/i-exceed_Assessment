import 'package:flutter/material.dart';

void main() {
  runApp(Card_ex());
}

class Card_ex extends StatelessWidget {
  const Card_ex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Center(
            child: Text(
              "Card widget",
              style: TextStyle(fontWeight: FontWeight.bold),
              //textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Center(
          child: Card(
            color: Colors.yellowAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            elevation: 40,
            shadowColor: Colors.red,
            borderOnForeground: true,
            child: Container(
              height: 200,
              color: Colors.red,
              child: Image(
                height: 100,
                width: double.infinity,
                image: NetworkImage(
                  'https://www.i-exceed.com/wp-content/uploads/2022/08/i-exceed-Hi-Res-copy-1.webp',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
