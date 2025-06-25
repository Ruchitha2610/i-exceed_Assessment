import 'dart:isolate';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IsolateExample(),
    );
  }
}

class IsolateExample extends StatefulWidget {
  @override
  _IsolateExampleState createState() => _IsolateExampleState();
}

class _IsolateExampleState extends State<IsolateExample> {
  String result = 'Waiting...';

  void startHeavyTask() async {
    final receivePort = ReceivePort(); // To receive messages from the isolate

    // Start the isolate
    await Isolate.spawn(heavyComputation, receivePort.sendPort);

    // Wait for the isolate to send back data
    final sendPort = await receivePort.first as SendPort;

    final answerPort = ReceivePort();
    sendPort.send([100000000, answerPort.sendPort]);

    final sum = await answerPort.first;
    setState(() {
      result = 'Sum is: $sum';
    });
  }

  // Entry point for isolate (has to be top-level or static)
  static void heavyComputation(SendPort mainSendPort) {
    final port = ReceivePort();

    // Send a SendPort back to main isolate so it can send data to this isolate
    mainSendPort.send(port.sendPort);

    port.listen((message) {
      final int n = message[0];
      final SendPort replyTo = message[1];

      int sum = 0;
      for (int i = 0; i < n; i++) {
        sum += i;
      }

      replyTo.send(sum);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Isolate Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startHeavyTask,
              child: Text('Start Heavy Task'),
            ),
          ],
        ),
      ),
    );
  }
}
