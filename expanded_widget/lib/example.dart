import 'package:flutter/material.dart';

void main() {
  runApp(const BankApp());
}

class BankApp extends StatelessWidget {
  const BankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Bank"),
          backgroundColor: Colors.indigo,
          centerTitle: true,
        ),
        body: Column(
          children: [
            // 🔷 Account Balance Box
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.indigo[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Balance",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\$8,750.00",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // 🔷 Expandable List of Transactions
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tx = transactions[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Text(
                        getEmoji(tx['type']),
                        style: const TextStyle(fontSize: 26),
                      ),
                      title: Text(
                        tx['type'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(tx['date']),
                      trailing: Text(
                        "${tx['amount']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              tx['amount'].toString().startsWith('-')
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔷 Dummy Transaction Data
List<Map<String, dynamic>> transactions = [
  {'type': 'Deposit', 'amount': '+\$500', 'date': '2025-06-01'},
  {'type': 'Transfer', 'amount': '-\$150', 'date': '2025-05-30'},
  {'type': 'Purchase', 'amount': '-\$75', 'date': '2025-05-29'},
  {'type': 'Deposit', 'amount': '+\$1,000', 'date': '2025-05-28'},
];

// 🔷 Emoji Based on Transaction Type
String getEmoji(String type) {
  switch (type) {
    case 'Deposit':
      return '💰';
    case 'Purchase':
      return '🛒';
    case 'Transfer':
      return '📤';
    default:
      return '💳';
  }
}
