import 'package:bank/register.dart';
import 'package:flutter/material.dart';

import 'exampledb.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => UsernamePageState();
}

class UsernamePageState extends State<UsernamePage> {
  RegisterPage ac = RegisterPage();
  final db = exampleDb();

  final formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();
  bool showSummary = false;
  String enteredUsername = '';
  String enteredNickname = '';

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  late double accnum;
  @override
  Widget build(BuildContext context) {
    Widget _buildFormFields() {
      return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Create Username',
                  hintText: 'Enter a unique username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  } else if (db.userData.containsKey(value)) {
                    return 'Username already exists';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Set Password',
                  hintText: 'Must include A-Z | a-z | 1-9 | symbols',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
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
                  } else if (value.length < 8 ||
                      !RegExp(r'[A-Za-z]').hasMatch(value) ||
                      !RegExp(r'\d').hasMatch(value) ||
                      !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Please enter a strong password with at least 8 characters\n Including letters, numbers, and special characters';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter password',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nicknameController,
                decoration: const InputDecoration(
                  labelText: 'Nickname (Optional)',
                  hintText: 'Enter your nickname',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.face),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildSummaryCard() {
      return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Registration Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Username: $enteredUsername"),
              Text(
                "Nickname: ${enteredNickname.isEmpty ? 'Not set' : enteredNickname}",
              ),

              Text("Account Number: ${accnum.toInt()}"),
            ],
          ),
        ),
      );
    }

    final arg = ModalRoute.of(context)!.settings.arguments;
    if (arg is String) {
      accnum = double.tryParse(arg) ?? 0.0; // or handle null properly
    } else {
      accnum = 0.0;
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(227, 247, 250, 1),

      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "User Registration",
                  style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 35),

            showSummary ? _buildSummaryCard() : _buildFormFields(),

            const SizedBox(height: 50),

            // Submit and Proceed buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:
                      isRegistered
                          ? null
                          : () {
                            if (formKey.currentState!.validate()) {
                              final username = usernameController.text;
                              final password = passwordController.text;
                              final nickname = nicknameController.text;

                              setState(() {
                                isRegistered = true;
                                showSummary = true;
                                enteredUsername = username;
                                enteredNickname = nickname;

                                db.accountNum[accnum] = username;
                                db.userData[username] = {
                                  "password": password,
                                  if (nickname.isNotEmpty) "nickname": nickname,
                                };
                              });

                              // Optionally show snackbar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Color.fromRGBO(
                                    0,
                                    150,
                                    255,
                                    1,
                                  ),
                                  content: Text('Registration Successful'),
                                ),
                              );
                            }
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(168, 153, 204, 255),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Submit", style: TextStyle(fontSize: 17)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed:
                      isRegistered
                          ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color.fromRGBO(0, 150, 255, 1),
                                content: Text('Proceeding to next screen...'),
                              ),
                            );
                            Navigator.pushNamed(
                              context,
                              '/set_passkey',
                              arguments: accnum,
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(168, 153, 204, 255),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Proceed", style: TextStyle(fontSize: 17)),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
