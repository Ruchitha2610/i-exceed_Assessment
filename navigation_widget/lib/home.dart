import 'package:flutter/material.dart';

import 'second.dart';

//1st page
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(width: double.infinity, color: Colors.blue, height: 100),
            SizedBox(height: 30),
            Container(width: double.infinity, color: Colors.grey, height: 100),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
