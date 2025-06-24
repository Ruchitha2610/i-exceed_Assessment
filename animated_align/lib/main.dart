import 'package:flutter/material.dart';

void main() {
  runApp(Animated_ex());
}

class Animated_ex extends StatefulWidget {
  const Animated_ex({super.key});

  @override
  State<Animated_ex> createState() => _Animated_exState();
}

class _Animated_exState extends State<Animated_ex> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: Center(
        child: Container(
          width: double.infinity,
          height: 300,
          color: Colors.purple,
          child: AnimatedAlign(
            alignment: selected ? Alignment.topRight : Alignment.bottomLeft,
            duration: Duration(seconds: 3),
            curve: Curves.slowMiddle,
            child: Image(
              height: 100,
              width: 100,
              image: NetworkImage(
                'https://www.i-exceed.com/wp-content/uploads/2022/08/i-exceed-Hi-Res-copy-1.webp',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
