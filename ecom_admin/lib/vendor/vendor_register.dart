import 'dart:async';
import 'dart:convert';

import 'package:ecom_admin/vendor/vendor_login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const beige = Color(0xFFF2EDD7);
const brown = Color(0xFF755139);
const fieldFill = Color(0xFFF9F6EF);

class VendorRegisterPage extends StatefulWidget {
  @override
  _VendorRegisterPageState createState() => _VendorRegisterPageState();
}

enum Stage { emailPassword, otp, businessDetails }

class _VendorRegisterPageState extends State<VendorRegisterPage> {
  Stage _stage = Stage.emailPassword;

  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  final _confirmC = TextEditingController();
  final _otpC = TextEditingController();
  final _fullC = TextEditingController();
  final _businessC = TextEditingController();
  final _storeIdC = TextEditingController();

  String? emailError,
      passError,
      confirmError,
      fullNameError,
      businessNameError,
      storeIdError;
  bool _passVisible = false, _confirmVisible = false;
  int _secondsLeft = 60;
  bool _canResend = false;
  Timer? _timer;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final passRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#\$%^&+=!]).{6,8}$',
  );
  final storeIdRegex = RegExp(r'^[A-Z]{2,6}_[A-Z]{2,5}_[0-9]{3}$');

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

  bool validateEmailPassword() {
    setState(() {
      emailError =
          _emailC.text.isEmpty
              ? 'Email is required'
              : (!emailRegex.hasMatch(_emailC.text)
                  ? 'Enter a valid email'
                  : null);
      passError =
          _passC.text.isEmpty
              ? 'Password is required'
              : (!passRegex.hasMatch(_passC.text)
                  ? '6–8 chars with upper, lower, number & special char'
                  : null);
      confirmError =
          _confirmC.text.isEmpty
              ? 'Confirm password is required'
              : (_confirmC.text != _passC.text
                  ? 'Passwords do not match'
                  : null);
    });

    return emailError == null && passError == null && confirmError == null;
  }

  Future<void> sendOtp() async {
    if (!validateEmailPassword()) return;

    final res = await http.post(
      Uri.parse('http://192.168.2.42:3000/vendor/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': _emailC.text, 'password': _passC.text}),
    );

    final j = jsonDecode(res.body);
    setState(() {
      if (res.statusCode == 200) {
        _stage = Stage.otp;
        startTimer();
      } else {
        emailError = j['error'];
      }
    });
  }

  Future<void> verifyOtp() async {
    if (_otpC.text.isEmpty) {
      showAlert("Error", "Please enter OTP");
      return;
    }

    final res = await http.post(
      Uri.parse('http://192.168.2.42:3000/vendor/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': _emailC.text, 'otp': _otpC.text}),
    );

    final j = jsonDecode(res.body);
    if (res.statusCode == 200) {
      setState(() {
        _stage = Stage.businessDetails;
        _timer?.cancel();
      });
    } else {
      showAlert("Invalid OTP", j['error'] ?? "OTP verification failed");
    }
  }

  Future<void> checkStoreId() async {
    final id = _storeIdC.text.trim().toUpperCase();
    _storeIdC.value = TextEditingValue(
      text: id,
      selection: TextSelection.collapsed(offset: id.length),
    );

    if (!storeIdRegex.hasMatch(id)) {
      setState(
        () => storeIdError = 'Store ID should be in format like SM_BLR_001',
      );
      return;
    }

    final res = await http.post(
      Uri.parse('http://192.168.2.42:3000/vendor/check-store-id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'storeId': id}),
    );

    final j = jsonDecode(res.body);
    if (!j['available']) {
      setState(() => storeIdError = j['message'] ?? 'Unavailable');
    } else {
      setState(() => storeIdError = null);
    }
  }

  Future<void> register() async {
    setState(() {
      fullNameError = _fullC.text.isEmpty ? 'Full Name required' : null;
      businessNameError =
          _businessC.text.isEmpty ? 'Business Name required' : null;
      storeIdError = _storeIdC.text.isEmpty ? 'Store ID required' : null;
    });

    if (fullNameError != null ||
        businessNameError != null ||
        storeIdError != null)
      return;

    await checkStoreId();
    if (storeIdError != null) return;

    final res = await http.post(
      Uri.parse('http://192.168.2.42:3000/vendor/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'fullName': _fullC.text,
        'businessName': _businessC.text,
        'storeId': _storeIdC.text,
        'email': _emailC.text,
        'password': _passC.text,
      }),
    );

    final j = jsonDecode(res.body);
    if (res.statusCode == 200) {
      showAlert("Success", "Registered successfully");
    } else {
      showAlert("Error", j['error'] ?? "Registration failed");
    }
  }

  void showAlert(String title, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => VendorLogin()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          ),
    );
  }

  InputDecoration inputDeco(
    String label,
    IconData icon,
    String? error, {
    bool isPassword = false,
    bool? visible,
    VoidCallback? toggle,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon:
          isPassword
              ? IconButton(
                icon: Icon(visible! ? Icons.visibility : Icons.visibility_off),
                onPressed: toggle,
              )
              : null,
      filled: true,
      fillColor: fieldFill,
      border: OutlineInputBorder(),
      errorText: error,
    );
  }

  Widget buildStepIndicator() {
    List<String> steps = [
      "Email & Password",
      "OTP Verification",
      "Business Details",
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            steps.asMap().entries.map((entry) {
              int i = entry.key;
              bool active = i == _stage.index;
              bool done = i < _stage.index;
              return Column(
                children: [
                  Icon(
                    done ? Icons.check_circle : Icons.radio_button_checked,
                    color: done || active ? brown : Colors.grey,
                  ),
                  Text(
                    entry.value,
                    style: TextStyle(
                      fontWeight: active ? FontWeight.bold : FontWeight.normal,
                      color: done || active ? brown : Colors.grey,
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
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
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(''), backgroundColor: brown),
      body: Column(
        children: [
          SizedBox(height: 10),
          buildStepIndicator(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: LinearProgressIndicator(
              value: (_stage.index + 1) / 3,
              color: brown,
              backgroundColor: Colors.grey[300],
            ),
          ),
          Expanded(
            child: Center(
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
                          'Vendor Registration',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16),
                        if (_stage == Stage.emailPassword) ...[
                          TextFormField(
                            controller: _emailC,
                            decoration: inputDeco(
                              'Email',
                              Icons.email,
                              emailError,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _passC,
                            obscureText: !_passVisible,
                            decoration: inputDeco(
                              'Password',
                              Icons.lock,
                              passError,
                              isPassword: true,
                              visible: _passVisible,
                              toggle:
                                  () => setState(
                                    () => _passVisible = !_passVisible,
                                  ),
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _confirmC,
                            obscureText: !_confirmVisible,
                            decoration: inputDeco(
                              'Confirm Password',
                              Icons.lock_outline,
                              confirmError,
                              isPassword: true,
                              visible: _confirmVisible,
                              toggle:
                                  () => setState(
                                    () => _confirmVisible = !_confirmVisible,
                                  ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: brown,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: sendOtp,
                              child: Text('Send OTP'),
                            ),
                          ),
                        ],
                        if (_stage == Stage.otp) ...[
                          TextFormField(
                            controller: _otpC,
                            decoration: inputDeco(
                              'Enter OTP',
                              Icons.message,
                              null,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text('Expires in $_secondsLeft seconds'),
                          SizedBox(height: 12),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: brown,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _secondsLeft > 0 ? verifyOtp : null,
                              child: Text('Verify OTP'),
                            ),
                          ),
                          if (_canResend)
                            TextButton(
                              onPressed: sendOtp,
                              child: Text('Resend OTP'),
                            ),
                        ],
                        if (_stage == Stage.businessDetails) ...[
                          TextFormField(
                            controller: _fullC,
                            decoration: inputDeco(
                              'Full Name',
                              Icons.person,
                              fullNameError,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _businessC,
                            decoration: inputDeco(
                              'Business Name',
                              Icons.business,
                              businessNameError,
                            ),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _storeIdC,
                            onChanged: (_) => checkStoreId(),
                            decoration: inputDeco(
                              'Store ID (e.g. SM_BLR_001)',
                              Icons.store,
                              storeIdError,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: brown,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: register,
                              child: Text('REGISTER'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
