import 'package:flutter/material.dart';

import 'admin/admin_forgot_password.dart';
import 'admin/admin_login.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/admin-login': (context) => AdminLoginPage(), // import this
        '/admin-forgot-password': (context) => ForgotPasswordPage(),
      },
      home: AdminLoginPage(),
    ),
  );
}
