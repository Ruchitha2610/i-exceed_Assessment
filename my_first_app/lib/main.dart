import 'package:flutter/material.dart';

void main() {
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Welcome",
      home: Home(),
      theme: ThemeData(scaffoldBackgroundColor: Colors.pinkAccent),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      primary: true,
      //backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200.0,
          width: 300.0,
          color: Colors.yellowAccent,
        ),
      ),
    );
  }
}
