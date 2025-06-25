import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: DividerDemo());
  }
}

class DividerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Divider & VerticalDivider Example')),
      body: Row(
        children: [
          // Left panel with vertical divider
          Expanded(
            child: Column(
              children: [
                ListTile(title: Text('Section 1')),
                Divider(
                  color: Colors.blue,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(title: Text('Section 2')),
                Divider(
                  color: Colors.green,
                  thickness: 2,
                  indent: 16,
                  endIndent: 16,
                ),
                ListTile(title: Text('Section 3')),
              ],
            ),
          ),

          // Vertical divider between columns
          VerticalDivider(
            color: Colors.grey,
            thickness: 1,
            width: 30,
            indent: 20,
            endIndent: 20,
          ),

          // Right panel
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info, size: 48, color: Colors.deepPurple),
                SizedBox(height: 10),
                Text('Details Panel', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
