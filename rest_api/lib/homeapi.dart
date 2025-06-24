import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CallMyApi extends StatefulWidget {
  const CallMyApi({super.key});

  @override
  State<CallMyApi> createState() => _CallMyApiState();
}

class _CallMyApiState extends State<CallMyApi> {
  Map<String, dynamic>? Mapdata;
  void initState() {
    hitApi();
    super.initState();
  }

  Future hitApi() async {
    http.Response response;
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    print(response.statusCode);
    Mapdata = jsonDecode(response.body);
    for (int i = 0; i < Mapdata!.length; i++) {
      print(Mapdata!['data'][i]['first_name']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'REST Handling http requests',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        shadowColor: Colors.redAccent,
        elevation: 20,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(Mapdata!['data'][0]['first_name']),
            subtitle: Text(Mapdata!['data'][0]['email']),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(Mapdata!['data'][1]['first_name']),
            subtitle: Text(Mapdata!['data'][1]['email']),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(Mapdata!['data'][2]['first_name']),
            subtitle: Text(Mapdata!['data'][2]['email']),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(Mapdata!['data'][3]['first_name']),
            subtitle: Text(Mapdata!['data'][3]['email']),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(Mapdata!['data'][4]['first_name']),
            subtitle: Text(Mapdata!['data'][4]['email']),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text(Mapdata!['data'][5]['first_name']),
            subtitle: Text(Mapdata!['data'][5]['email']),
          ),
        ],
      ),
    );
  }
}
