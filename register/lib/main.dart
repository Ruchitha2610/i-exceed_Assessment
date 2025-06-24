import 'package:flutter/material.dart';

void main() {
  runApp(Register());
}

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.indigo),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 700,
                  width: double.infinity,
                  color: Colors.purple,
                ),
                Positioned(
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 55,
                              width: double.infinity,
                              color: Colors.white,
                              margin: EdgeInsets.all(30.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
