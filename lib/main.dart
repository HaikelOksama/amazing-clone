import 'dart:developer';

import 'package:amazon/auth_gate.dart';
import 'package:amazon/firebase_options.dart';
import 'package:amazon/screen/home_screen.dart';
import 'package:amazon/screen/login_screen.dart';
import 'package:amazon/screen/register_screen.dart';
import 'package:amazon/utils/colors_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final user = FirebaseAuth.instance;
    return MaterialApp(
      initialRoute: user.currentUser == null ? '/auth' : '/home',
      routes: {
        '/auth': (context) => const AuthGate(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen()
      },
      title: 'Amazon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: yellowColor),
    );
  }
}
