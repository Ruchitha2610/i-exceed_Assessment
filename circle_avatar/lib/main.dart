import 'package:flutter/material.dart';

void main() {
  runApp(Circle_Ex());
}

class Circle_Ex extends StatelessWidget {
  const Circle_Ex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Center(
            child: Text(
              "Circle Avatar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
        ),
        body: Center(
          child: CircleAvatar(
            radius: 125,
            child: CircleAvatar(
              //radius: 100,
              backgroundColor: Colors.deepPurpleAccent,
              foregroundColor: Colors.blue,
              child: Icon(Icons.person, size: 100.0),
              backgroundImage: AssetImage('assets/images/vegetables.jpeg'),
              foregroundImage: AssetImage('assets/images/icecream.jpeg'),
              maxRadius:
                  100, //max and min radius can be used only when radius is null
            ),
          ),
        ),
      ),
    );
  }
}
