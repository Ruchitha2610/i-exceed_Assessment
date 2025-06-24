import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'exampledb.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool obscurePass = true;
  bool obscureConfirmPass = true;
  final usernameController = TextEditingController();
  final otpController = TextEditingController();
  int resendCountdown = 0; // seconds left to enable resend
  Timer? countdownTimer;
  int otpExpirySecondsLeft = 60;
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool showPasswordFields = false;
  bool passwordChangedSuccess = false;

  final db = exampleDb();

  String? generatedOtp;
  bool otpFieldVisible = false;
  bool otpVerified = false;

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

  void handlePasswordReset() {
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();
    if (!_formKey.currentState!.validate()) return;

    if (newPass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill both password fields."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Simulate password reset
    String username = usernameController.text.trim();
    db.userData[username]?['password'] = newPass;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password reset successful!"),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      showPasswordFields = false;
      otpVerified = false;
      generatedOtp = null;
      otpFieldVisible = false;
      otpController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      passwordChangedSuccess = true; // show success screen
    });
  }

  void handleOtpSend() {
    final username = usernameController.text;

    bool usernameExists = db.userData.containsKey(username);

    if (!usernameExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username not found."),
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
    countdownTimer?.cancel();
    otpExpiryTimer?.cancel();

    if (otpController.text == generatedOtp) {
      otpVerified = true;

      setState(() {
        showPasswordFields = true; // Show password fields after successful OTP
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP verified. Set your new password."),
          backgroundColor: Colors.green,
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
  }

  @override
  void dispose() {
    otpExpiryTimer?.cancel();
    resendOtpTimer?.cancel();
    countdownTimer?.cancel();
    usernameController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    if (passwordChangedSuccess) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(168, 0, 51, 102),
          title: const Text(
            "FinTrest",
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              fontFamily: "serif",
            ),
          ),
        ),
        body: const Center(
          child: Text(
            "Password changed successfully!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

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
                "Regenerate new Password",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              TextFormField(
                controller: usernameController,
                //keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Enter your Username",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_2_sharp),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              if (!otpVerified)
                ElevatedButton(
                  onPressed:
                      (!canResend && generatedOtp != null)
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

              if (!otpVerified) ...[
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
              ],
              if (otpFieldVisible && !otpVerified) ...[
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
                  onPressed: handleOtpVerification,
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
              const SizedBox(height: 20),
              if (otpVerified && showPasswordFields) ...[
                const SizedBox(height: 30),
                TextFormField(
                  controller: newPasswordController,
                  obscureText:
                      obscurePass, // Toggle visibility using the obscurePass variable
                  decoration: InputDecoration(
                    labelText: "New Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePass ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass; // Toggle the visibility
                        });
                        //print('New Password obscurePass is now: $obscurePass');
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    final passwordRegExp = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{8,}$',
                    );
                    if (!passwordRegExp.hasMatch(value)) {
                      return 'Please enter a strong password with at least 8 characters\n Including letters, numbers, and special characters';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText:
                      obscureConfirmPass, // Toggle visibility using the obscureConfirmPass variable
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPass =
                              !obscureConfirmPass; // Toggle the visibility
                        });
                        //print('Confirm Password obscureConfirmPass is now: $obscureConfirmPass',);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: handlePasswordReset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Submit", style: TextStyle(fontSize: 17)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
