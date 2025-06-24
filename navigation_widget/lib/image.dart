import 'package:flutter/material.dart';

import 'main.dart';

//3rd page
class Img extends StatelessWidget {
  const Img({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Image(
            image: NetworkImage(
              'https://media.istockphoto.com/id/1419410282/photo/silent-forest-in-spring-with-beautiful-bright-sun-rays.jpg?s=612x612&w=0&k=20&c=UHeb1pGOw6ozr6utsenXHhV19vW6oiPIxDqhKCS2Llk=',
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Main()),
              );
            },
            child: Text('Go to home'),
          ),
        ],
      ),
    );
  }
}
