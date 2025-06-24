import 'package:flutter/material.dart';

import 'example_db.dart'; // Import the simulated DB

class EasyLoginPage extends StatefulWidget {
  const EasyLoginPage({super.key});

  @override
  State<EasyLoginPage> createState() => _EasyLoginPageState();
}

class _EasyLoginPageState extends State<EasyLoginPage> {
  final TextEditingController passkeyController = TextEditingController();
  bool isPasskeyObscured = true;
  String? passkeyError; // For showing error below the passkey field

  final OutlineInputBorder boxBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey),
  );

  void login() {
    String enteredPasskey = passkeyController.text.trim();
    Map<String, String> reverseMap = getReverseUserDatabase();

    setState(() {
      passkeyError = null; // Clear previous error
    });

    if (enteredPasskey.isEmpty || enteredPasskey.length != 6) {
      setState(() {
        passkeyError = "Enter a valid 6-lowercase letters passkey";
      });
      return;
    }

    if (reverseMap.containsKey(enteredPasskey)) {
      String accNum = reverseMap[enteredPasskey]!;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login successful")));
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
    } else {
      setState(() {
        passkeyError = "Invalid passkey";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 247, 250, 1),
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 30, 60, 100)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Login using Passkey",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Colors.black,
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
      ),
    );
  }
}
