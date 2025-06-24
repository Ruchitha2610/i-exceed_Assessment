import 'package:flutter/material.dart';

void main() {
  runApp(Splash_ex());
}

class Splash_ex extends StatelessWidget {
  const Splash_ex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue, title: Text("splash")),
      ),
    );
  }
}
