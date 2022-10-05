import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        actions: [
          CircleAvatar(
            child: IconButton(
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/auth', (route) => false);
                  await FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.person)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Center(
              child: Text('Hi'),
            )
          ],
        ),
      ),
    );
  }
}
