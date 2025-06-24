import 'package:flutter/material.dart';

void main() {
  runApp(RenderFlex());
}

//error occurs if Expanded is  not used :A RenderFlex overflowed by 1739 pixels on the right.
class RenderFlex extends StatelessWidget {
  const RenderFlex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text(
            "Expanded widget",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(right: 10.0, top: 5.0),
                child: Image(
                  width: 200.0,
                  height: 200.0,
                  image: NetworkImage(
                    'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Image(
                  image: NetworkImage(
                    'https://images.ctfassets.net/hrltx12pl8hq/3Z1N8LpxtXNQhBD5EnIg8X/975e2497dc598bb64fde390592ae1133/spring-images-min.jpg',
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
