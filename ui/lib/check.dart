import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// Simulated database for username-password mapping
Map<String, String> userDatabase = {
  '1234567890': 'abcdef',
}; // Simulated backend storage
Map<String, String> getReverseUserDatabase() {
  return {for (var entry in userDatabase.entries) entry.value: entry.key};
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SetPasskeyPage(),
    );
  }
}

class SetPasskeyPage extends StatefulWidget {
  @override
  _SetPasskeyPageState createState() => _SetPasskeyPageState();
}

class _SetPasskeyPageState extends State<SetPasskeyPage> {
  final TextEditingController accController = TextEditingController();
  final TextEditingController passkeyController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String generatedOtp = '';
  int attemptsLeft = 3;
  int _timeLeft = 0;
  Timer? _timer;

  bool showOtpField = false;
  bool isOtpExpired = false;

  bool isPasskeyObscured = true;
  bool isConfirmObscured = true;

  final OutlineInputBorder boxBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.grey),
  );

  bool isValidPasskey(String passkey) {
    return RegExp(r'^[a-z]{6}$').hasMatch(passkey);
  }

  void startTimer() {
    _timeLeft = 60;
    isOtpExpired = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
        setState(() {
          isOtpExpired = true;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("OTP expired!")));
      } else {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void sendOtp() {
    if (_formKey.currentState!.validate()) {
      if (!userDatabase.containsKey(accController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Account not registered!")),
        );
        return;
      }

      generatedOtp = (1000 + Random().nextInt(9000)).toString();
      attemptsLeft = 3;
      otpController.clear();

      setState(() {
        showOtpField = true;
        isOtpExpired = false;
      });

      startTimer();

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fix errors before sending OTP")),
      );
    }
  }

  void verifyOtp() {
    if (!showOtpField || isOtpExpired) return;

    if (otpController.text == generatedOtp) {
      _timer?.cancel();
      userDatabase[accController.text] = passkeyController.text;

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Success"),
              content: const Text("Passkey set successfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    accController.clear();
                    passkeyController.clear();
                    confirmController.clear();
                    otpController.clear();

                    setState(() {
                      showOtpField = false;
                    });

                    Navigator.pop(context); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EasyLoginPage()),
                    );
                  },
                  child: const Text("OK"),
                ),
              ],
            ),
      );
    } else {
      attemptsLeft--;
      if (attemptsLeft == 0) {
        _timer?.cancel();
        setState(() {
          isOtpExpired = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Too many attempts! Try again later.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Incorrect OTP. Attempts left: $attemptsLeft"),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(227, 247, 250, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 30, 60, 100),
        title: const Text("Set Passkey"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Set Passkey",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                      validator: (value) {
                        if (value == null ||
                            value.length < 10 ||
                            !RegExp(r'^\d+$').hasMatch(value)) {
                          return "Enter at least 10 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passkeyController,
                      obscureText: isPasskeyObscured,
                      decoration: InputDecoration(
                        labelText: "Set Passkey",
                        prefixIcon: const Icon(Icons.key),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasskeyObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasskeyObscured = !isPasskeyObscured;
                            });
                          },
                        ),
                        border: boxBorder,
                        enabledBorder: boxBorder,
                        focusedBorder: boxBorder,
                      ),
                      validator: (value) {
                        if (value == null || !isValidPasskey(value)) {
                          return "Must be 6 lowercase letters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: confirmController,
                      obscureText: isConfirmObscured,
                      decoration: InputDecoration(
                        labelText: "Confirm Passkey",
                        prefixIcon: const Icon(Icons.key_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmObscured = !isConfirmObscured;
                            });
                          },
                        ),
                        border: boxBorder,
                        enabledBorder: boxBorder,
                        focusedBorder: boxBorder,
                      ),
                      validator: (value) {
                        if (value != passkeyController.text) {
                          return "Passkeys do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: sendOtp,
                      child: const Text("Send OTP"),
                    ),
                    const SizedBox(height: 20),
                    if (showOtpField) ...[
                      Text(
                        isOtpExpired
                            ? "OTP expired"
                            : "OTP expires in: $_timeLeft seconds",
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        enabled: !isOtpExpired,
                        decoration: InputDecoration(
                          labelText: "Enter OTP",
                          prefixIcon: const Icon(Icons.key),
                          border: boxBorder,
                          enabledBorder: boxBorder,
                          focusedBorder: boxBorder,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrangeAccent,
                        ),
                        onPressed: isOtpExpired ? null : verifyOtp,
                        child: const Text("Set"),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';

//import 'example_db.dart'; // Import the simulated DB

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasskeyPage(),
                    ),
                  );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterApp()),
                    );
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

class ForgotPasskeyPage extends StatefulWidget {
  const ForgotPasskeyPage({super.key});

  @override
  State<ForgotPasskeyPage> createState() => _ForgotPasskeyPageState();
}

class _ForgotPasskeyPageState extends State<ForgotPasskeyPage> {
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

    if (!RegExp(r'^[a-z]{6}$').hasMatch(pass1)) {
      passError = "Passkey must be exactly 6 lowercase letters";
      valid = false;
    }

    if (pass1 != pass2) {
      confirmPassError = "Passkeys do not match";
      valid = false;
    }

    if (!userDatabase.containsKey(accNum)) {
      accError = "Account is not registered";
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
    userDatabase[accController.text.trim()] = newPassController.text.trim();

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EasyLoginPage()),
                  );
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
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 30, 60, 100)),
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

class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: RegisterPage(), debugShowCheckedModeBanner: false);
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController accController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

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
    String accNum = accController.text.trim();
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
    if (userDatabase.containsKey(accNum)) {
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
      userDatabase[accNum] = dob;

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
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 30, 60, 100),
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
              decoration: BoxDecoration(
                border: Border.all(
                  color: accError ? Colors.red : Colors.grey,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: accController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Account Number",
                  border: InputBorder.none,
                  icon: Icon(Icons.account_balance),
                ),
                onChanged:
                    (_) => setState(() {
                      accError = false;
                      accErrorMsg = null;
                    }),
              ),
            ),
            if (accErrorMsg != null)
              Padding(
                padding: EdgeInsets.only(top: 5, left: 8),
                child: Text(
                  accErrorMsg!,
                  style: TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
            SizedBox(height: 30),

            // DOB Field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: dobError ? Colors.red : Colors.grey,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: dobController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDOB(context),
                  ),
                ),
              ),
            ),
            if (dobErrorMsg != null)
              Padding(
                padding: EdgeInsets.only(top: 5, left: 8),
                child: Text(
                  dobErrorMsg!,
                  style: TextStyle(color: Colors.red, fontSize: 13),
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
