import 'dart:developer';
import 'package:amazon/resources/cloud_firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();

    String output = 'Something Went Wrong!';
    if (name != '' && address != '' && email != '' && password != '') {
      output = 'success';
      if (!email.contains('@')) {
        return 'Email Should Contain @';
      }
      try {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final signIn = await signInUser(
          email: email,
          password: password,
        );
        if (signIn == 'success') {
          auth.currentUser!.sendEmailVerification();
          await CloudFirestoreMethods()
              .updateUserInfo(name: name, address: address);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          output = 'Please Enter Correct Email';
        } else if (e.code == 'weak-password') {
          output = 'Password is Too Weak Bor';
        }
      }
    } else {
      output = 'Fill up everything!';
    }
    return output;
  }

  Future<String> signInUser({
    required String email,
    required String password,
  }) async {
    email.trim();
    password.trim();

    String output = 'Something Went Wrong!';

    if (email != '' && password != '') {
      if (!email.contains("@")) {
        return 'Email Should Contain @';
      }
      try {
        output = 'success';
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        log(e.code);
        if (e.code == 'invalid-email') {
          output = 'Please Enter Correct Email';
        } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          output = 'Email or Password is wrong!';
        } else if (e.code == 'too-many-requests') {
          output = 'Please Try Again Later : Too Many Request';
        } else {
          output = 'Oops! Something Went Wrong! ${e.code}';
        }
      }
    } else {
      output = 'Please Fill Up Everything';
    }

    return output;
  }

  // TODO : Add Other Auth Functionality

}
