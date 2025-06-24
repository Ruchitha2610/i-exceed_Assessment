import 'package:flutter/material.dart';

import 'items.dart'; //import the items file to pass into UI flutter

void main() {
  runApp(ItemApp());
}

class ItemApp extends StatelessWidget {
  const ItemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Items List",
          style: TextStyle(
            color: Colors.purpleAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, int index) {
          final isHovered = hoveredIndex == index;

          return MouseRegion(
            onEnter: (_) => setState(() => hoveredIndex = index),
            onExit: (_) => setState(() => hoveredIndex = null),
            child: Container(
              color: isHovered ? Colors.tealAccent.withOpacity(0.3) : null,
              child: ListTile(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Tapped on ${obj[index].name}")),
                  );
                },
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(obj[index].image),
                ),
                title: Text(
                  obj[index].name,
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(obj[index].type),
                trailing: Icon(Icons.shopping_cart),
                horizontalTitleGap: 50.0,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.grey, thickness: 2.0);
        },
        itemCount: obj.length,
      ),
    );
  }
}
