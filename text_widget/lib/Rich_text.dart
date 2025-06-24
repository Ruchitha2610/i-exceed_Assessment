import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(RichTextEx());
}

class RichTextEx extends StatelessWidget {
  const RichTextEx({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(
            "RichText widget",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
        ),
        body: Center(
          child: RichText(
            text: TextSpan(
              text: 'Click ',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: 'here',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          print('Link tapped!');
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
