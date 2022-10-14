import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreMethods {
  FirebaseAuth authInstance = FirebaseAuth.instance;
  FirebaseFirestore cloudInstance = FirebaseFirestore.instance;

  Future updateUserInfo({required String name, required String address}) async {
    await cloudInstance
        .collection("users")
        .doc(authInstance.currentUser!.uid)
        .set({
      "name": name,
      "address": address,
    });
  }
}
