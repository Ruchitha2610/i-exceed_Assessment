import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Text_rich());
}

class Text_rich extends StatelessWidget {
  const Text_rich({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Text.rich constructor",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Text.rich(
            TextSpan(
              text: "Hello\n",
              children: [
                TextSpan(
                  text: "i-exceed\n",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 20.0,
                  ),
                  children: [
                    TextSpan(
                      text: "Sign up?",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueAccent,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              print("Signed up....");
                            },
                    ),
                  ],
                ),
              ],
              style: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
                color: Colors.brown,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
