import 'package:flutter/material.dart';

void main() {
  runApp(Positioned_Ex());
}

class Positioned_Ex extends StatelessWidget {
  const Positioned_Ex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: Text(
            "Positioned Widget",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: 400.0,
              width: 400.0,
              child: Image(
                image: NetworkImage(
                  "https://image-processor-storage.s3.us-west-2.amazonaws.com/images/3cf61c1011912a2173ea4dfa260f1108/halo-of-neon-ring-illuminated-in-the-stunning-landscape-of-yosemite.jpg",
                ),
              ),
            ),
            Positioned(
              height:
                  100.0, //height and width of positioned has higher priority than container height and width
              width: 100.0,
              left: 150.0,
              top: 150.0,
              child: Container(
                //height: 100,
                //width: 100,
                child: Image(
                  image: NetworkImage(
                    "https://img.freepik.com/free-photo/closeup-scarlet-macaw-from-side-view-scarlet-macaw-closeup-head_488145-3540.jpg?semt=ais_hybrid&w=740",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
