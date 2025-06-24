import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'signup.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(), //for "key" any string names can be used
        '/login':
            (context) =>
                Login(), //for 'values' the class to which it should be routed is given
        '/signup': (context) => SignUp(),
      },
    );
  }
}
