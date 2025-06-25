import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum Gender { male, female, other }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioButtonExample(),
    );
  }
}

class RadioButtonExample extends StatefulWidget {
  @override
  _RadioButtonExampleState createState() => _RadioButtonExampleState();
}

class _RadioButtonExampleState extends State<RadioButtonExample> {
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Radio Button Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Male'),
              leading: Radio<Gender>(
                value: Gender.male,
                groupValue: _selectedGender,
                onChanged: (Gender? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Female'),
              leading: Radio<Gender>(
                value: Gender.female,
                groupValue: _selectedGender,
                onChanged: (Gender? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Other'),
              leading: Radio<Gender>(
                value: Gender.other,
                groupValue: _selectedGender,
                onChanged: (Gender? value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selected: ${_selectedGender != null ? _selectedGender.toString().split('.').last : 'None'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
