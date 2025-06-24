import 'package:flutter/material.dart';

void main() => runApp(MyBankApp());

class MyBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BankDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BankDashboard extends StatefulWidget {
  @override
  _BankDashboardState createState() => _BankDashboardState();
}

class _BankDashboardState extends State<BankDashboard> {
  bool _showBalance = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                color: Colors.indigo,
                padding: EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello, Ruchitha 👋',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              Positioned(
                right: 16,
                top: 40,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              AnimatedAlign(
                alignment:
                    _showBalance ? Alignment.center : Alignment.topCenter,
                duration: Duration(seconds: 5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showBalance = !_showBalance;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 120),
                    padding: EdgeInsets.all(16),
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.grey.shade300),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text('Balance', style: TextStyle(color: Colors.grey)),
                        Text(
                          '₹1,25,000',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Quick Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 100,
            child: ListView.separated(
              padding: EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(width: 10),
              itemBuilder: (context, index) {
                List<String> actions = [
                  'Send Money',
                  'Pay Bills',
                  'Recharge',
                  'Request Loan',
                ];
                return Container(
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(actions[index], textAlign: TextAlign.center),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              List<String> titles = [
                'Amazon',
                'Flipkart',
                'Swiggy',
                'Zomato',
                'Netflix',
              ];
              List<String> dates = [
                'Today',
                'Yesterday',
                '2 days ago',
                '3 days ago',
                'Last Week',
              ];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                ),
                title: Text(titles[index]),
                subtitle: Text(dates[index]),
                trailing: Text(
                  '- ₹${(index + 1) * 500}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '💸 Get 5% cashback on UPI payments!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
