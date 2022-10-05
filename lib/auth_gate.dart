import 'package:amazon/screen/home_screen.dart';
import 'package:amazon/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || FirebaseAuth.instance.currentUser == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        });
  }
}
