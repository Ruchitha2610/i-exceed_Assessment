import 'package:flutter/material.dart';

import 'easy_login.dart';
import 'forgot_passkey.dart';
import 'register.dart';
import 'set_passkey.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login_passkey',
      routes: {
        '/register': (context) => RegisterApp(),
        '/login_passkey': (context) => EasyLoginPage(),
        '/forgot_passkey': (context) => ForgotPasskeyPage(),
        '/set_passkey': (context) => SetPasskeyPage(),
      },
    ),
  );
}
