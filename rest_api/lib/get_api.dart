import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(Get_Api());
}

class Get_Api extends StatefulWidget {
  const Get_Api({super.key});

  @override
  State<Get_Api> createState() => _Get_ApiState();
}

class _Get_ApiState extends State<Get_Api> {
  void initState() {
    super.initState();
    getApi();
  }

  Future getApi() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    print(response.statusCode);
    var dataMap = jsonDecode(response.body);
    //print(dataMap);
    List luser = [];
    for (var i in dataMap['data']) {
      User u = User(
        first_name: i['first_name'],
        last_name: i['last_name'],
        email: i['email'],
      );
      luser.add(u);
    }
    print(luser.runtimeType);
    return luser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.tealAccent,
          title: Text('Get API', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: FutureBuilder(
          future: getApi(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext c, int index) {
                  return ListTile(
                    leading: CircleAvatar(child: Icon(Icons.person)),
                    title: Text(snapshot.data[index].first_name),
                    subtitle: Text(snapshot.data[index].email),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class User {
  String? first_name, last_name, email;
  User({this.first_name, this.last_name, this.email});

  // factory User.fromjson() {
  //   return User();
  // }
}
