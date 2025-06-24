import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(AnimalApp());

class AnimalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Animal Database', home: AnimalForm());
  }
}

class AnimalForm extends StatefulWidget {
  @override
  _AnimalFormState createState() => _AnimalFormState();
}

class _AnimalFormState extends State<AnimalForm> {
  final nameController = TextEditingController();
  final speciesController = TextEditingController();
  final ageController = TextEditingController();
  List animals = [];

  final String apiUrl =
      'http://192.168.2.42:3000/animals'; // Replace with your IP

  Future<void> addAnimal() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': nameController.text,
        'species': speciesController.text,
        'age': int.parse(ageController.text),
      }),
    );
    if (response.statusCode == 201) {
      fetchAnimals();
    }
  }

  Future<void> fetchAnimals() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        animals = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Animal Database')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: speciesController,
                decoration: InputDecoration(labelText: 'Species'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(onPressed: addAnimal, child: Text('Add Animal')),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: animals.length,
                  itemBuilder: (context, index) {
                    final animal = animals[index];
                    return ListTile(
                      title: Text('${animal['name']} (${animal['species']})'),
                      subtitle: Text('Age: ${animal['age']}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
