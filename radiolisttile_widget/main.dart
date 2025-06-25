import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum PaymentMethod { creditCard, debitCard, netBanking }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioListTileExample(),
    );
  }
}

class RadioListTileExample extends StatefulWidget {
  @override
  _RadioListTileExampleState createState() => _RadioListTileExampleState();
}

class _RadioListTileExampleState extends State<RadioListTileExample> {
  PaymentMethod? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RadioListTile Example')),
      body: Column(
        children: [
          RadioListTile<PaymentMethod>(
            title: Text('Credit Card'),
            subtitle: Text('Pay using your credit card'),
            value: PaymentMethod.creditCard,
            groupValue: _selectedMethod,
            onChanged: (PaymentMethod? value) {
              setState(() {
                _selectedMethod = value;
              });
            },
          ),
          RadioListTile<PaymentMethod>(
            title: Text('Debit Card'),
            subtitle: Text('Pay using your debit card'),
            value: PaymentMethod.debitCard,
            groupValue: _selectedMethod,
            onChanged: (PaymentMethod? value) {
              setState(() {
                _selectedMethod = value;
              });
            },
          ),
          RadioListTile<PaymentMethod>(
            title: Text('Net Banking'),
            subtitle: Text('Pay directly from your bank account'),
            value: PaymentMethod.netBanking,
            groupValue: _selectedMethod,
            onChanged: (PaymentMethod? value) {
              setState(() {
                _selectedMethod = value;
              });
            },
          ),
          SizedBox(height: 20),
          Text(
            'Selected: ${_selectedMethod != null ? _selectedMethod.toString().split('.').last : 'None'}',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
