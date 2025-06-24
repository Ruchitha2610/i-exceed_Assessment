import 'package:bank/register.dart';
import 'package:bank/set_passkey.dart';
import 'package:bank/user_register.dart';
import 'package:flutter/material.dart';

import 'ForgotPassword.dart';
import 'ForgotUsername.dart';
import 'exampledb.dart';
import 'forgot_passkey.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/home': (context) => CombinedLogin(),
        '/user': (context) => UsernamePage(),
        '/register': (context) => RegisterPage(),
        '/set_passkey': (context) => SetPasskeyPage(),
        '/forgot_passkey': (context) => ForgotPasskeyPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const CombinedLogin(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Color(0xFF0D47A1), fontSize: 18),
          hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 16),
          prefixStyle: const TextStyle(color: Color(0xFF0D47A1), fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF0D47A1), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF1976D2), width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red.shade800, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red.shade800, width: 1.5),
          ),
        ),
      ),
    ),
  );
}

class CombinedLogin extends StatelessWidget {
  const CombinedLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(227, 247, 250, 1),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 30, 60, 100),
          title: const Text(
            "FinTrest",
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontFamily: "serif",
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            const SizedBox(height: 40),
            // Stylish card for tab switcher
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Color.fromARGB(255, 153, 204, 255),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'Username Login'),
                    Tab(text: 'Passkey Login'),
                  ],
                  indicatorPadding: EdgeInsets.all(4),
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
            ),
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/bank_logo.jpg'),
              backgroundColor:
                  Colors.transparent, // optional: makes the background clean
            ),

            const SizedBox(height: 40),

            const Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(child: UserLoginSection()),
                  SingleChildScrollView(child: EasyLoginSection()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------- Username/Password Login Section -------------------

class UserLoginSection extends StatefulWidget {
  const UserLoginSection({super.key});

  @override
  State<UserLoginSection> createState() => _UserLoginSectionState();
}

class _UserLoginSectionState extends State<UserLoginSection> {
  final formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final db = exampleDb();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Text(
            "Login using Username",
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 35),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',

                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username is required';
                } else if (!db.userData.containsKey(value)) {
                  return 'Username does not exist';
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotUsername(),
                  ),
                );
              },
              child: const Text("Forgot Username?"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                } else {
                  final username = usernameController.text;
                  if (db.userData.containsKey(username)) {
                    if (db.userData[username]!['password'] != value) {
                      return 'Incorrect password';
                    }
                  }
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgotPassword(),
                  ),
                );
              },
              child: const Text("Forgot Password?"),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final username = usernameController.text;
                final nicknameMap = db.userData[username];
                String displayName = username;

                if (nicknameMap != null) {
                  final nickname = nicknameMap['nickname'];
                  if (nickname != null && nickname.isNotEmpty) {
                    displayName = nickname;
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Welcome back, $displayName!',
                      style: const TextStyle(fontSize: 18),
                    ),
                    backgroundColor: const Color.fromRGBO(0, 150, 255, 1),
                  ),
                );
              }
            },
            //navigation to dashboard page
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
              backgroundColor: Colors.green,
            ),
            child: const Text("Login", style: TextStyle(fontSize: 17)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// ------------------- Easy Login (Passkey) Section -------------------

class EasyLoginSection extends StatefulWidget {
  const EasyLoginSection({super.key});

  @override
  State<EasyLoginSection> createState() => _EasyLoginSectionState();
}

class _EasyLoginSectionState extends State<EasyLoginSection> {
  final TextEditingController passkeyController = TextEditingController();
  bool isPasskeyObscured = true;
  String? passkeyError; // For showing error below the passkey field
  final db = exampleDb();

  final OutlineInputBorder boxBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey),
  );

  void login() {
    String enteredPasskey = passkeyController.text.trim();
    Map<String, String> reverseMap = db.getReverseUserDatabase();
    print(reverseMap);
    setState(() {
      passkeyError = null; // Clear previous error
    });

    if (enteredPasskey.isEmpty || enteredPasskey.length != 6) {
      setState(() {
        passkeyError = "Enter a valid 6 letters passkey";
      });
      return;
    }

    if (reverseMap.containsKey(enteredPasskey)) {
      String accNum = reverseMap[enteredPasskey]!;
      final username = db.accountNum[double.tryParse(accNum)];
      final nicknameMap = db.userData[username];
      String? displayName = username;

      if (nicknameMap != null) {
        final nickname = nicknameMap['nickname'];
        if (nickname != null && nickname.isNotEmpty) {
          displayName = nickname;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Welcome back, $displayName!',
            style: const TextStyle(fontSize: 18),
          ),
          backgroundColor: const Color.fromRGBO(0, 150, 255, 1),
        ),
      );
    } else {
      setState(() {
        passkeyError = "Invalid passkey";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Login using Passkey",
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passkeyController,
            obscureText: isPasskeyObscured,
            decoration: InputDecoration(
              labelText: "Passkey",
              prefixIcon: const Icon(Icons.key),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasskeyObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isPasskeyObscured = !isPasskeyObscured;
                  });
                },
              ),
              errorText: passkeyError,
              border: boxBorder,
              enabledBorder: boxBorder,
              focusedBorder: boxBorder,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot_passkey');
              },
              child: const Text(
                "Forgot Passkey?",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 4),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40),
              backgroundColor: Colors.green,
            ),
            onPressed: login,
            child: const Text("Login"),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
