import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'exampledb.dart';

class ForgotPasskeyPage extends StatefulWidget {
  const ForgotPasskeyPage({super.key});

  @override
  State<ForgotPasskeyPage> createState() => _ForgotPasskeyPageState();
}

class _ForgotPasskeyPageState extends State<ForgotPasskeyPage> {
  final db = exampleDb();

  final accController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final otpController = TextEditingController();

  bool otpSent = false;
  String generatedOtp = '';
  int attemptsLeft = 3;
  Timer? otpTimer;
  int remainingSeconds = 0;

  String? accError;
  String? passError;
  String? confirmPassError;
  String? otpError;

  bool isNewPassObscured = true;
  bool isConfirmPassObscured = true;

  void sendOtp() {
    setState(() {
      accError = passError = confirmPassError = otpError = null;
    });

    String accNum = accController.text.trim();
    String pass1 = newPassController.text.trim();
    String pass2 = confirmPassController.text.trim();

    bool valid = true;

    if (!RegExp(r'^\d{10,}$').hasMatch(accNum)) {
      accError = "Account number must be at least 10 digits";
      valid = false;
    }

    if (!RegExp(r'^[a-z,A-Z]{6}$').hasMatch(pass1)) {
      passError = "Passkey must be exactly 6 letters";
      valid = false;
    }

    if (pass1 != pass2) {
      confirmPassError = "Passkeys do not match";
      valid = false;
    }

    if (!db.userDatabase.containsKey(accNum)) {
      accError = "Account is not registered";
      valid = false;
    }
    if (db.userDatabase.containsValue(newPassController.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passkey already in use!")));
      valid = false;
    }
    if (!valid) {
      setState(() {});
      return;
    }

    generatedOtp = generateOtp();
    otpSent = true;
    attemptsLeft = 3;
    remainingSeconds = 60;

    startTimer();

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("OTP Sent"),
            content: Text("Your OTP is: $generatedOtp"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK"),
              ),
            ],
          ),
    );

    setState(() {});
  }

  void startTimer() {
    otpTimer?.cancel();
    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        setState(() {
          otpSent = false;
          otpError = "OTP expired. Please request a new one.";
        });
      } else {
        setState(() {
          remainingSeconds--;
        });
      }
    });
  }

  void changePasskey() {
    setState(() => otpError = null);

    if (remainingSeconds == 0) {
      otpError = "OTP expired. Please request again.";
      return;
    }

    if (otpController.text.trim() != generatedOtp) {
      attemptsLeft--;
      if (attemptsLeft == 0) {
        otpError = "Too many failed attempts. OTP is blocked.";
        otpSent = false;
        otpTimer?.cancel();
      } else {
        otpError = "Incorrect OTP. $attemptsLeft attempt(s) left.";
      }
      setState(() {});
      return;
    }

    otpTimer?.cancel();
    db.userDatabase[accController.text.trim()] = newPassController.text.trim();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Success"),
            content: const Text("Passkey changed successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );

    accController.clear();
    newPassController.clear();
    confirmPassController.clear();
    otpController.clear();
    setState(() {
      otpSent = false;
    });
  }

  String generateOtp() {
    Random r = Random();
    return (r.nextInt(9000) + 1000).toString();
  }

  final OutlineInputBorder boxBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey),
  );

  @override
  void dispose() {
    otpTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: const Color.fromRGBO(227, 247, 250, 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Forgot passkey',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: accController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Account Number",
                prefixIcon: const Icon(Icons.account_balance),
                border: boxBorder,
                enabledBorder: boxBorder,
                focusedBorder: boxBorder,
              ),
            ),
            if (accError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  accError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 30),
            TextFormField(
              controller: newPassController,
              obscureText: isNewPassObscured,
              decoration: InputDecoration(
                labelText: "Set New Passkey",
                prefixIcon: const Icon(Icons.key),
                suffixIcon: IconButton(
                  icon: Icon(
                    isNewPassObscured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isNewPassObscured = !isNewPassObscured;
                    });
                  },
                ),
                border: boxBorder,
                enabledBorder: boxBorder,
                focusedBorder: boxBorder,
              ),
            ),
            if (passError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  passError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 30),
            TextFormField(
              controller: confirmPassController,
              obscureText: isConfirmPassObscured,
              decoration: InputDecoration(
                labelText: "Confirm Passkey",
                prefixIcon: const Icon(Icons.key_outlined),
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPassObscured
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPassObscured = !isConfirmPassObscured;
                    });
                  },
                ),
                border: boxBorder,
                enabledBorder: boxBorder,
                focusedBorder: boxBorder,
              ),
            ),
            if (confirmPassError != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  confirmPassError!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: sendOtp,
                child: const Text("Send OTP"),
              ),
            ),
            const SizedBox(height: 20),
            if (otpSent) ...[
              TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Enter OTP",
                  prefixIcon: const Icon(Icons.message),
                  border: boxBorder,
                  enabledBorder: boxBorder,
                  focusedBorder: boxBorder,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "OTP expires in: $remainingSeconds seconds",
                style: const TextStyle(color: Colors.red),
              ),
              if (otpError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    otpError!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: changePasskey,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Change"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
