import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloudFirestoreMethods {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future updateUserInfo({required String name, required String address}) async {
    await users.doc(authInstance.currentUser!.uid).set({
      "name": name,
      "address": address,
    });
  }

  Future<Map<String, dynamic>> getUser() async {
    final docs = await users.doc(authInstance.currentUser!.uid).get();
    return docs as Map<String, dynamic>;
  }

  dynamic getUserInfo() => FutureBuilder<DocumentSnapshot>(
        future: users.doc(authInstance.currentUser!.uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(data.keys.toString());
          }
          return const AspectRatio(
            aspectRatio: 1,
            child: CircularProgressIndicator(),
          );
        },
      );

  Future<String> getUserAddress() async {
    final docs = await users.doc(authInstance.currentUser!.uid).get();
    String message = 'Please Wait';
    try {
      Map<String, dynamic> data = docs.data() as Map<String, dynamic>;
      return data['address'];
    } catch (e) {
      message = 'Something Went Wrong! $e';
    }
    return message;
  }
}
