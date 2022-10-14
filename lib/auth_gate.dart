import 'dart:developer';

import 'package:amazon/screen/home_screen.dart';
import 'package:amazon/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    log(FirebaseAuth.instance.currentUser.toString());
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 100,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CircularProgressIndicator(color: Colors.orange),
                ),
              ),
            );
          } else if (!snapshot.hasData ||
              FirebaseAuth.instance.currentUser == null) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        });
  }
}
