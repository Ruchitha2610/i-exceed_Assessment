import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'exampledb.dart';

class ForgotUsername extends StatefulWidget {
  const ForgotUsername({super.key});

  @override
  State<ForgotUsername> createState() => _ForgotUsernameState();
}

class _ForgotUsernameState extends State<ForgotUsername> {
  final _formKey = GlobalKey<FormState>();
  final accountController = TextEditingController();
  final otpController = TextEditingController();
  int resendCountdown = 0; // seconds left to enable resend
  Timer? countdownTimer;
  int otpExpirySecondsLeft = 60;

  final db = exampleDb();

  String? generatedOtp;
  bool otpFieldVisible = false;
  bool otpVerified = false;
  String? recoveredUsername;

  int otpAttempts = 0;
  bool canResend = false;
  Timer? otpExpiryTimer;
  Timer? resendOtpTimer;

  String generateOtp() {
    final random = Random();
    return (1000 + random.nextInt(9000)).toString(); // 4-digit OTP
  }

  void startTimers() {
    otpExpiryTimer?.cancel();
    countdownTimer?.cancel();

    otpExpirySecondsLeft = 60;
    resendCountdown = 15;
    canResend = false;

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (otpExpirySecondsLeft > 0) {
          otpExpirySecondsLeft--;
        }

        if (resendCountdown > 0) {
          resendCountdown--;
        }

        if (resendCountdown == 0) {
          canResend = true;
        }
        if (otpExpirySecondsLeft == 0 && !otpVerified) {
          generatedOtp = null;
          otpFieldVisible = false;
          timer.cancel();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("OTP expired"),
              backgroundColor: Colors.orange,
            ),
          );
        }
      });
    });
  }

  void handleOtpSend() {
    final account = accountController.text;

    bool accountExists = db.accountNum.containsKey(double.tryParse(account));

    if (!accountExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account number not found."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (otpAttempts >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Maximum OTP attempts reached."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    generatedOtp = generateOtp();
    otpAttempts++;
    otpFieldVisible = true;
    canResend = false;
    otpVerified = false;
    recoveredUsername = null;

    startTimers();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("OTP Sent"),
            content: Text("Your OTP is: $generatedOtp"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );

    setState(() {});
  }

  void handleOtpVerification() {
    if (otpController.text == generatedOtp) {
      double account = double.parse(accountController.text);
      recoveredUsername = db.accountNum[account];
      otpVerified = true;

      // Cancel timers to prevent further updates
      countdownTimer?.cancel();
      otpExpiryTimer?.cancel();

      // Clear OTP-related state to hide timers and messages
      otpExpirySecondsLeft = 0;
      resendCountdown = 0;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Don't forget your username. Keep it safe."),
          backgroundColor: Colors.blueAccent,
          duration: Duration(seconds: 10),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid OTP."),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    setState(() {});
  }

  @override
  void dispose() {
    otpExpiryTimer?.cancel();
    resendOtpTimer?.cancel();
    countdownTimer?.cancel();
    accountController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendOtpButton = ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          handleOtpSend();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 76, 175, 80),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(
        canResend ? "Resend OTP" : "Send OTP",
        style: const TextStyle(fontSize: 17),
      ),
    );

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Recover Username",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Account Number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Account number is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    (otpVerified || (!canResend && generatedOtp != null))
                        ? null
                        : () {
                          if (_formKey.currentState!.validate()) {
                            handleOtpSend();
                          }
                        },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 175, 80),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  canResend || generatedOtp == null
                      ? (generatedOtp == null ? "Send OTP" : "Resend OTP")
                      : "Wait ${resendCountdown}s",
                  style: const TextStyle(fontSize: 17),
                ),
              ),
              if (generatedOtp != null && otpExpirySecondsLeft > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "OTP expires in ${otpExpirySecondsLeft}s",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              if (otpFieldVisible) ...[
                const SizedBox(height: 30),
                TextFormField(
                  controller: otpController,
                  decoration: const InputDecoration(
                    labelText: "Enter OTP",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: !otpVerified ? handleOtpVerification : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 33, 150, 243),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    "Verify OTP",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],

              if (otpVerified && recoveredUsername != null) ...[
                const SizedBox(height: 30),
                Text(
                  "Your Username is: $recoveredUsername",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
