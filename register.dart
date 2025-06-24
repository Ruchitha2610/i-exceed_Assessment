import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'exampledb.dart';

class RegisterPage extends StatefulWidget {
  String get accNum => accNum;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String accNum = '';
  final TextEditingController accController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final db = exampleDb();

  String generatedOtp = '';
  int failedAttempts = 0;
  bool accError = false;
  bool dobError = false;
  bool otpSent = false;
  String? accErrorMsg;
  String? dobErrorMsg;

  int secondsRemaining = 0;
  Timer? otpTimer;
  Timer? countdownTimer;

  void _selectDOB(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
        dobError = false;
        dobErrorMsg = null;
      });
    }
  }

  void _sendOTP() {
    accNum = accController.text.trim();
    String dob = dobController.text.trim();

    setState(() {
      accError = accNum.isEmpty || !RegExp(r'^\d{10,}$').hasMatch(accNum);
      dobError = dob.isEmpty;

      accErrorMsg =
          accError
              ? (accNum.isEmpty
                  ? "Account Number is required"
                  : "Account Number must be at least 10 digits")
              : null;

      dobErrorMsg = dobError ? "Date of Birth is required" : null;
    });

    if (accError || dobError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fix errors before sending OTP")),
      );
      return;
    }

    // 🔐 Check if already registered
    if (db.userDatabase.containsKey(accNum)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Account already registered")));
      return;
    }

    // ✅ Proceed with OTP Generation
    Random random = Random();
    generatedOtp = (1000 + random.nextInt(9000)).toString();
    failedAttempts = 0;
    otpSent = true;
    otpController.clear();
    secondsRemaining = 60;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("OTP Sent"),
            content: Text("Your OTP is: $generatedOtp"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
    );

    countdownTimer?.cancel();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });

    otpTimer?.cancel();
    otpTimer = Timer(Duration(seconds: 60), () {
      countdownTimer?.cancel();
      setState(() {
        generatedOtp = '';
        otpController.clear();
        otpSent = false;
        secondsRemaining = 0;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("OTP expired")));
    });
  }

  void _verifyOTP() {
    if (generatedOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No OTP available. Please send again.")),
      );
      return;
    }

    if (otpController.text == generatedOtp) {
      otpTimer?.cancel();
      countdownTimer?.cancel();

      // ✅ Save new user to the simulated database
      String accNum = accController.text.trim();
      String dob = dobController.text.trim();
      db.userDatabase[accNum] = dob;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("OTP Verified! Proceed")));

      // Optional: clear fields

      setState(() {
        accController.clear();
        dobController.clear();
        otpController.clear();
        otpSent = false;
        generatedOtp = '';
      });
      Navigator.pushNamed(context, '/user', arguments: accNum);
    } else {
      failedAttempts++;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP. Attempt $failedAttempts/3")),
      );

      if (failedAttempts >= 3) {
        otpTimer?.cancel();
        countdownTimer?.cancel();
        setState(() {
          generatedOtp = '';
          otpController.clear();
          otpSent = false;
          secondsRemaining = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("OTP cleared after 3 failed attempts")),
        );
      }
    }
  }

  @override
  void dispose() {
    accController.dispose();
    dobController.dispose();
    otpController.dispose();
    otpTimer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 247, 250, 1),

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'poppins',
                ),
              ),
            ),
            SizedBox(height: 40),

            // Account Number Field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),

              child: TextField(
                controller: accController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Account Number",
                  border: InputBorder.none,
                  errorText: accError ? accErrorMsg : null,
                  prefixIcon: Icon(Icons.account_balance),
                ),
                onChanged:
                    (_) => setState(() {
                      accError = false;
                      accErrorMsg = null;
                    }),
              ),
            ),

            SizedBox(height: 50),

            // DOB Field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),

              child: TextField(
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: InputBorder.none,
                  errorText: dobError ? dobErrorMsg : null,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDOB(context),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Send OTP Button
            Center(
              child: ElevatedButton(
                onPressed: _sendOTP,
                child: Text("Send OTP"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 76, 175, 80),
                ),
              ),
            ),

            SizedBox(height: 20),

            // OTP Entry and Timer & Verify Button
            if (otpSent)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter OTP",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message),
                    ),
                  ),
                  SizedBox(height: 10),

                  if (secondsRemaining > 0)
                    Text(
                      "OTP expires in $secondsRemaining seconds",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),

                  SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(168, 153, 204, 255),
                      ),
                      onPressed: _verifyOTP,
                      child: Text("Verify"),
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
