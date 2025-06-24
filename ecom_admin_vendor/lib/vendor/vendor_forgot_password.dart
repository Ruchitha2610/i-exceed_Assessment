import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailC = TextEditingController();
  final otpC = TextEditingController();
  final newPassC = TextEditingController();
  final confirmC = TextEditingController();

  String? emailError, otpError, newPassError, confirmPassError;

  bool otpSent = false;
  bool otpVerified = false;
  bool showPassword = false;

  Timer? _timer;
  int _secondsLeft = 60;
  bool _canResend = false;
  int otpAttempts = 0;

  final uri = 'http://192.168.2.42:3000/vendor';

  void startTimer() {
    _secondsLeft = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _secondsLeft--;
        if (_secondsLeft <= 0) {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> sendOtp() async {
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailC.text)) {
      setState(() => emailError = 'Enter a valid email');
      return;
    }

    final res = await http.post(
      Uri.parse('$uri/send-forgot-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': emailC.text}),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      setState(() {
        otpSent = true;
        otpVerified = false;
        otpAttempts = 0; // ✅ Reset attempts
        otpError = null; // ✅ Clear error
        otpC.clear(); // ✅ Clear old OTP
        startTimer(); // ✅ Restart timer
      });
    } else {
      setState(() => emailError = data['error'] ?? 'Failed to send OTP');
    }
  }

  Future<void> verifyOtp() async {
    if (otpAttempts >= 3) {
      setState(() {
        otpError = 'Too many incorrect attempts. Please resend OTP.';
      });
      return;
    }

    if (otpC.text.isEmpty) {
      setState(() => otpError = 'Enter OTP');
      return;
    }

    final res = await http.post(
      Uri.parse('$uri/verify-forgot-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': emailC.text, 'otp': otpC.text}),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      setState(() => otpVerified = true);
    } else {
      setState(() {
        otpAttempts++;
        if (otpAttempts >= 3) {
          otpError = 'Too many incorrect attempts. Please resend OTP.';
        } else {
          otpError = data['error'] ?? 'Invalid OTP';
        }
      });
    }
  }

  Future<void> resetPassword() async {
    setState(() {
      newPassError = null;
      confirmPassError = null;
    });

    String password = newPassC.text;
    String confirm = confirmC.text;

    if (password.isEmpty)
      newPassError = 'Enter new password';
    else if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#\\$%^&+=!]).{6,8}$',
    ).hasMatch(password)) {
      newPassError =
          'Password must be 6–8 chars with upper, lower, number & symbol';
    }

    if (confirm.isEmpty)
      confirmPassError = 'Confirm password';
    else if (password != confirm)
      confirmPassError = 'Passwords do not match';

    if (newPassError != null || confirmPassError != null) {
      setState(() {});
      return;
    }

    final res = await http.post(
      Uri.parse('$uri/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': emailC.text, 'newPassword': password}),
    );

    final data = jsonDecode(res.body);
    if (res.statusCode == 200) {
      Navigator.pop(context);
    } else {
      setState(
        () => confirmPassError = data['error'] ?? 'Failed to reset password',
      );
    }
  }

  InputDecoration deco(
    String label,
    IconData icon,
    String? error, {
    bool password = false,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon:
          password
              ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(() => showPassword = !showPassword),
              )
              : null,
      filled: true,
      fillColor: Color(0xFFF9F6EF),
      border: OutlineInputBorder(),
      errorText: error,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""), backgroundColor: Color(0xFF755139)),
      backgroundColor: Colors.white,
      body: Center(
        child: Card(
          color: Color(0xFFF2EDD7),
          margin: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color(0xFF755139), width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailC,
                    enabled: !otpSent,
                    decoration: deco("Email", Icons.email, emailError),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: sendOtp,
                    child: Text(
                      "Send OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF755139),
                    ),
                  ),
                  if (otpSent) ...[
                    SizedBox(height: 12),
                    TextFormField(
                      controller: otpC,
                      enabled: !otpVerified,
                      decoration: deco("Enter OTP", Icons.lock_clock, otpError),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed:
                          (otpAttempts >= 3 || otpVerified)
                              ? null
                              : verifyOtp, // ✅ Disable button after 3 attempts
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            (otpAttempts >= 3 || otpVerified)
                                ? Colors.grey
                                : Color(0xFF755139),
                      ),
                    ),
                    if (_secondsLeft > 0)
                      Text('OTP expires in $_secondsLeft seconds')
                    else if (_canResend)
                      TextButton(onPressed: sendOtp, child: Text("Resend OTP")),
                  ],
                  if (otpVerified) ...[
                    SizedBox(height: 12),
                    TextFormField(
                      controller: newPassC,
                      obscureText: !showPassword,
                      decoration: deco(
                        "New Password",
                        Icons.lock,
                        newPassError,
                        password: true,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: confirmC,
                      obscureText: !showPassword,
                      decoration: deco(
                        "Confirm Password",
                        Icons.lock_outline,
                        confirmPassError,
                        password: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: resetPassword,
                      child: Text(
                        "Reset Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF755139),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
