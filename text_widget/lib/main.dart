import 'package:flutter/material.dart';

void main() {
  runApp(Text_widget());
}

class Text_widget extends StatelessWidget {
  const Text_widget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Text(
            "Text widget",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(
              "A text widget is a UI element used to display text in a user interface, often within a specific application or platform. These widgets allow for presenting text information in a structured and customizable way. They are a fundamental part of building applications and interfaces, enabling the display of labels, titles, descriptions, and other textual content.",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: 20.0,
                fontFamily: 'serif',
                letterSpacing: 1.0,
                wordSpacing: 20.0,
                //backgroundColor: Colors.orangeAccent,
                //decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                decorationStyle: TextDecorationStyle.dashed,
                decorationThickness: 2.0,
                shadows: [
                  Shadow(
                    offset: Offset(10, 10),
                    color: Colors.red,
                    blurRadius: 10.0,
                  ),
                ],
              ),
              maxLines: 8,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              //textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }
}
