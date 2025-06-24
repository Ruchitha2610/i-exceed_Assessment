import 'package:flutter/material.dart';

void main() {
  runApp(Stack_ex());
}

class Stack_ex extends StatelessWidget {
  const Stack_ex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(
            "Stack widget",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Container(
          height: 700,
          width: 500,
          color: Colors.red,
          child: Stack(
            fit: StackFit.expand, //works only for non positioned widgets
            alignment: //works only for Non positioned widgets
                Alignment
                    .center, //This tells the Stack to position all its children relative to the top center of the stack’s box.
            children: [
              Container(
                height: 300.0,
                width: 300.0,
                color: Colors.green,
              ), //Non positioned widget
              Positioned(
                left: 100,
                bottom: 250,
                child: Container(
                  height: 200.0,
                  width: 300.0,
                  color: Colors.orange,
                ),
              ),
              Positioned(
                left: 20,
                bottom: 0.0,
                child: Container(height: 200, width: 200, color: Colors.blue),
              ),
              Positioned(
                height: 100,
                width: 100,
                right: 20,
                top: 30,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellowAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
