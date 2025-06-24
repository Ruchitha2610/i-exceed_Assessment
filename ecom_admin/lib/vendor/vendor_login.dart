import 'dart:async';
import 'dart:convert';

import 'package:ecom_admin/vendor/vendor_forgot_password.dart';
import 'package:ecom_admin/vendor/vendor_register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: VendorLogin()));

const beige = Color(0xFFF2EDD7);
const brown = Color(0xFF755139);
const fieldFill = Color(0xFFF9F6EF);

class VendorLogin extends StatefulWidget {
  @override
  _VendorLoginState createState() => _VendorLoginState();
}

class _VendorLoginState extends State<VendorLogin> {
  final _storeIdC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _otpC = TextEditingController();

  bool _fieldsDisabled = false;
  bool _showPass = false;
  bool _otpSent = false;
  int _secondsLeft = 60;
  int _otpAttempts = 0;
  final int _maxOtpAttempts = 3;
  Timer? _timer;
  bool _canResend = false;

  String? storeIdError, emailError, passError, otpError, loginError;

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
    setState(() {
      storeIdError = _storeIdC.text.isEmpty ? 'Store ID required' : null;
      emailError = _emailC.text.isEmpty ? 'Email required' : null;
      passError = _passC.text.isEmpty ? 'Password required' : null;
      loginError = null;
    });

    if (_storeIdC.text.isEmpty || _emailC.text.isEmpty || _passC.text.isEmpty)
      return;

    final res = await http.post(
      Uri.parse('http://192.168.2.42:3000/vendor/send-login-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'storeId': _storeIdC.text,
        'email': _emailC.text,
        'password': _passC.text,
      }),
    );

    final j = jsonDecode(res.body);
    if (res.statusCode == 200) {
      setState(() {
        _otpSent = true;
        _otpAttempts = 0;
        _fieldsDisabled = true;
        startTimer();
      });
    } else {
      setState(() {
        loginError = j['error'] ?? 'Failed to send OTP';
      });
    }
  }

  Future<void> login() async {
    setState(() {
      storeIdError = _storeIdC.text.isEmpty ? 'Store ID required' : null;
      emailError = _emailC.text.isEmpty ? 'Email required' : null;
      passError = _passC.text.isEmpty ? 'Password required' : null;
      otpError = _otpC.text.isEmpty ? 'OTP required' : null;
      loginError = null;
    });

    if (storeIdError != null ||
        emailError != null ||
        passError != null ||
        otpError != null)
      return;

    final res = await http.post(
      Uri.parse('http://192.168.2.42:3000/vendor/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'storeId': _storeIdC.text,
        'email': _emailC.text,
        'password': _passC.text,
        'otp': _otpC.text,
      }),
    );

    final j = jsonDecode(res.body);
    if (res.statusCode == 200) {
      _timer?.cancel();
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text("Login Successful"),
              content: Text("Welcome to your dashboard."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog first
                    // TODO: Navigate to vendor dashboard
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => VendorDashboard()),
                    // );
                  },
                  child: Text("OK"),
                ),
              ],
            ),
      );
    } else {
      setState(() {
        _otpAttempts++;
        loginError = j['error'] ?? 'Login failed';

        if (_otpAttempts >= _maxOtpAttempts) {
          _otpC.clear();

          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: Text("Too Many Attempts"),
                  content: Text(
                    "You have reached the maximum number of OTP attempts. Please wait for the timer to complete to resend OTP.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"),
                    ),
                  ],
                ),
          );
        }
      });
    }
  }

  InputDecoration inputDeco(
    String label,
    IconData icon,
    String? error, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon:
          isPassword
              ? IconButton(
                icon: Icon(_showPass ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _showPass = !_showPass),
              )
              : null,
      filled: true,
      fillColor: fieldFill,
      border: OutlineInputBorder(),
    );
  }

  Widget errorText(String? error) {
    return error == null
        ? SizedBox.shrink()
        : Padding(
          padding: const EdgeInsets.only(top: 4, left: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(""), backgroundColor: brown),
      body: Center(
        child: Card(
          color: beige,
          margin: EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: brown, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Vendor Login",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _storeIdC,
                    enabled: !_fieldsDisabled,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (val) {
                      _storeIdC.value = _storeIdC.value.copyWith(
                        text: val.toUpperCase(),
                        selection: TextSelection.collapsed(offset: val.length),
                      );
                    },
                    decoration: inputDeco(
                      "Store ID",
                      Icons.store,
                      storeIdError,
                    ),
                  ),
                  errorText(storeIdError),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _emailC,
                    enabled: !_fieldsDisabled,
                    decoration: inputDeco(
                      "Store Email",
                      Icons.email,
                      emailError,
                    ),
                  ),
                  errorText(emailError),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _passC,
                    enabled: !_fieldsDisabled,
                    obscureText: !_showPass,
                    decoration: inputDeco(
                      "Password",
                      Icons.lock,
                      passError,
                      isPassword: true,
                    ),
                  ),
                  errorText(passError),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed:
                          _fieldsDisabled
                              ? null
                              : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ForgotPasswordPage(),
                                  ),
                                );
                              },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: _fieldsDisabled ? Colors.grey : brown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: sendOtp,
                    style: ElevatedButton.styleFrom(backgroundColor: brown),
                    child: Text(
                      "Send OTP",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  if (_otpSent) ...[
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _otpC,
                      decoration: inputDeco(
                        "Enter OTP",
                        Icons.message,
                        otpError,
                      ),
                    ),
                    errorText(otpError),
                    SizedBox(height: 4),
                    if (_secondsLeft > 0)
                      Text('OTP expires in $_secondsLeft seconds')
                    else if (_canResend && _otpAttempts >= _maxOtpAttempts)
                      TextButton(onPressed: sendOtp, child: Text("Resend OTP")),
                    if (_otpAttempts >= _maxOtpAttempts)
                      Text(
                        "Maximum OTP attempts reached. Please wait for the timer to complete to resend OTP.",
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                  if (loginError != null) ...[
                    SizedBox(height: 8),
                    Text(
                      loginError!,
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(backgroundColor: brown),
                    child: Text("LOGIN", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account? ",
                        style: TextStyle(color: Colors.black87),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VendorRegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
