import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldMessengerExample(),
    );
  }
}

class ScaffoldMessengerExample extends StatelessWidget {
  void _showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('This is a Snackbar!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Action logic here
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Undo clicked!')));
          },
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ScaffoldMessenger Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSnackbar(context),
          child: Text('Show Snackbar'),
        ),
      ),
    );
  }
}
