import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final emailCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String stage = 'email'; // 'email' → 'otp'
  String error = '';
  bool passwordVisible = false;

  final cardColor = const Color(0xFFF2EDD7);
  final buttonColor = const Color(0xFF755139);
  final textFieldFill = const Color(0xFFF9F6EF);

  Future<void> next() async {
    setState(() => error = '');
    final email = emailCtrl.text.trim();
    final password = passwordCtrl.text.trim();

    if (stage == 'email') {
      if (email.isEmpty ||
          !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        return setState(() => error = 'Enter a valid email');
      }
      if (password.isEmpty) {
        return setState(() => error = 'Enter password');
      }

      final res = await http.post(
        Uri.parse('http://192.168.2.42:3000/admin/login-initiate'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        setState(() => stage = 'otp');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'OTP sent to your email')),
        );
      } else {
        setState(() => error = data['message']);
      }
    } else if (stage == 'otp') {
      final otp = otpCtrl.text.trim();
      if (otp.isEmpty) return setState(() => error = 'Enter OTP');

      final res = await http.post(
        Uri.parse('http://192.168.2.42:3000/admin/login-verify'),
        body: jsonEncode({'email': email, 'code': otp}),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Logged in to dashboard'),
            backgroundColor: buttonColor,
          ),
        );
        // TODO: Navigate to Dashboard here
      } else {
        setState(() => error = data['message']);
      }
    }
  }

  Widget buildLoginCard(double width) {
    return Container(
      width: width < 500 ? width * 0.9 : 420,
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: buttonColor, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Admin Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailCtrl,
                enabled: stage == 'email',
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: textFieldFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: passwordCtrl,
                enabled: stage == 'email',
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed:
                        () =>
                            setState(() => passwordVisible = !passwordVisible),
                  ),
                  filled: true,
                  fillColor: textFieldFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              if (stage == 'otp') ...[
                SizedBox(height: 12),
                TextField(
                  controller: otpCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    prefixIcon: Icon(Icons.sms),
                    filled: true,
                    fillColor: textFieldFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
              if (error.isNotEmpty) ...[
                SizedBox(height: 12),
                Text(error, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 20),
              if (stage == 'email')
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/admin-forgot-password');
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: buttonColor),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: next,
                  child: Text(
                    stage == 'email' ? 'Send OTP' : 'Verify OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDesktop = screenWidth >= 900;

    return Scaffold(
      backgroundColor: Colors.white,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child:
            isDesktop
                ? Column(
                  children: [
                    ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.4,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "assets/images/login_banner.png",
                              fit: BoxFit.fill,
                            ),
                            Container(color: Color(0xAA755139)),
                            Center(
                              child: Text(
                                "Hello 👋 Welcome!",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    buildLoginCard(screenWidth),
                  ],
                )
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          width: double.infinity,
                          height: screenWidth * 9 / 16,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                "assets/images/login_banner.png",
                                fit: BoxFit.cover,
                              ),
                              Container(color: Color(0xAA755139)),
                              Center(
                                child: Text(
                                  "Hello 👋 Welcome!",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildLoginCard(screenWidth),
                    ],
                  ),
                ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
