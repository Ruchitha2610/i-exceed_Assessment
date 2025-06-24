import 'package:flutter/material.dart';

import 'employeeinfo.dart';

void main() {
  runApp(Team());
}

class Team extends StatelessWidget {
  const Team({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Populate the team"),
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: obj.length,
          itemBuilder: (BuildContext context, int index) {
            return getTeam(index);
          },
        ),
      ),
    );
  }
}

Widget getTeam(int index) {
  return ListTile(
    leading: CircleAvatar(
      radius: 20.0,
      backgroundImage: AssetImage("assets/images/trainee"),
    ),
    title: Text(obj[index].name),
    subtitle: Text(obj[index].desig),
    textColor: Colors.blueAccent,
  );
}
