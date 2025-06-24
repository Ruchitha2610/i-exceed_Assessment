import 'package:flutter/material.dart';

void main() {
  runApp(Ex_2());
}

class Ex_2 extends StatelessWidget {
  const Ex_2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              "Stack _ex2",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: Center(
          child: Stack(
            clipBehavior: Clip.hardEdge,
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: 300,
                width: 300,
                child: Image(
                  image: NetworkImage(
                    'https://bsmedia.business-standard.com/_media/bs/img/article/2018-02/25/full/1519583321-0217.jpg',
                  ),
                ),
              ),
              Positioned(
                top: -100, //clipBehavior works here
                left: -10,
                right: -10,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image(
                    image: NetworkImage(
                      'https://neontri.com/wp-content/uploads/2024/04/Illustration-Innovative_Features_That_will_Define_Mobile_Banking_Apps_By_2030_512x512_v001.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
