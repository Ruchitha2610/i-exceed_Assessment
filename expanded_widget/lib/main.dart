import 'package:flutter/material.dart';

void main() {
  runApp(Expanded_widget());
}

class Expanded_widget extends StatelessWidget {
  const Expanded_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 45, //default flex value is 1
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.redAccent,
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.yellowAccent,
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                height: 100.0,
                width: 100.0,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
