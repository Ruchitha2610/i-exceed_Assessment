import 'package:flutter/material.dart';

import 'homeapi.dart';

void main() {
  runApp(RestAPI());
}

class RestAPI extends StatefulWidget {
  const RestAPI({super.key});

  @override
  State<RestAPI> createState() => _RestAPIState();
}

class _RestAPIState extends State<RestAPI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: CallMyApi());
    ;
  }
}
