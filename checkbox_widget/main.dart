import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckboxExample(),
    );
  }
}

class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool reading = false;
  bool traveling = false;
  bool gaming = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkbox Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('Reading'),
              value: reading,
              onChanged: (bool? value) {
                setState(() {
                  reading = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Traveling'),
              value: traveling,
              onChanged: (bool? value) {
                setState(() {
                  traveling = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Gaming'),
              value: gaming,
              onChanged: (bool? value) {
                setState(() {
                  gaming = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Selected hobbies: ${_getSelectedHobbies()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String _getSelectedHobbies() {
    List<String> selected = [];
    if (reading) selected.add('Reading');
    if (traveling) selected.add('Traveling');
    if (gaming) selected.add('Gaming');
    return selected.isNotEmpty ? selected.join(', ') : 'None';
  }
}
