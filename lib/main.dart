import 'package:amazon/auth_gate.dart';
import 'package:amazon/firebase_options.dart';

import 'package:amazon/layout/main_layout.dart';
import 'package:amazon/screen/forgot_password_screen.dart';
import 'package:amazon/screen/login_screen.dart';
import 'package:amazon/screen/register_screen.dart';
import 'package:amazon/utils/colors_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthGate(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const PasswordResetScreen(),
        '/home': (context) => const MainLayout(),
      },
      title: 'A-mazing',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: yellowColor),
    );
  }
}
