import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckboxListTileExample(),
    );
  }
}

class CheckboxListTileExample extends StatefulWidget {
  @override
  _CheckboxListTileExampleState createState() =>
      _CheckboxListTileExampleState();
}

class _CheckboxListTileExampleState extends State<CheckboxListTileExample> {
  bool isPythonSelected = false;
  bool isJavaSelected = false;
  bool isFlutterSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CheckboxListTile Example')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          CheckboxListTile(
            title: Text('Python'),
            subtitle: Text('Versatile and beginner-friendly'),
            value: isPythonSelected,
            onChanged: (bool? value) {
              setState(() {
                isPythonSelected = value!;
              });
            },
            secondary: Icon(Icons.code),
          ),
          CheckboxListTile(
            title: Text('Java'),
            subtitle: Text('Popular for enterprise applications'),
            value: isJavaSelected,
            onChanged: (bool? value) {
              setState(() {
                isJavaSelected = value!;
              });
            },
            secondary: Icon(Icons.computer),
          ),
          CheckboxListTile(
            title: Text('Flutter'),
            subtitle: Text('Cross-platform app development'),
            value: isFlutterSelected,
            onChanged: (bool? value) {
              setState(() {
                isFlutterSelected = value!;
              });
            },
            secondary: Icon(Icons.smartphone),
          ),
          SizedBox(height: 20),
          Text(
            'Selected: ${_getSelectedLanguages()}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  String _getSelectedLanguages() {
    List<String> selected = [];
    if (isPythonSelected) selected.add("Python");
    if (isJavaSelected) selected.add("Java");
    if (isFlutterSelected) selected.add("Flutter");
    return selected.isNotEmpty ? selected.join(', ') : 'None';
  }
}
