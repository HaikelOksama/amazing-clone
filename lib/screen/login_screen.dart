import 'dart:developer';

import 'package:amazon/utils/constant.dart';
import 'package:amazon/utils/utility.dart';
import 'package:amazon/widgets/custom_button.dart';
import 'package:amazon/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/alert_dialog.dart';
import 'package:amazon/resources/auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  String errorMsg = '';
  bool buttonLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = Utils().getScreenSize();
    void sendHome(context) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  amazonLogo,
                  height: screenSize.height * 0.10,
                ),
                Container(
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.5,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign-In',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w300),
                      ),
                      CustomTextField(
                          title: 'Email',
                          obsecureText: false,
                          hintText: 'Enter Your Email',
                          textEditingController: _email),
                      CustomTextField(
                          title: 'Password',
                          obsecureText: true,
                          hintText: 'Enter Your Password',
                          textEditingController: _password),
                      Center(
                        child: Text(
                          errorMsg,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      Center(
                          child: SizedBox(
                        height: 40,
                        width: screenSize.width * 0.5,
                        child: CustomButton(
                          onPressed: () async {
                            try {
                              setState(() {
                                buttonLoading = !buttonLoading;
                              });

                              final signIn = await AuthMethods().signInUser(
                                  email: _email.text.trim(),
                                  password: _password.text.trim());
                              if (signIn == 'success') {
                                var user = FirebaseAuth.instance.currentUser;
                                if (!user!.emailVerified) {
                                  await FirebaseAuth.instance.signOut();
                                  await showCustomDialog(
                                    context: context,
                                    title: 'Attention',
                                    content:
                                        "We've sent email verification, once verified you may login",
                                    action: () async {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                  setState(() {
                                    buttonLoading = !buttonLoading;
                                  });
                                } else {
                                  if (!mounted) return;
                                  sendHome(context);
                                }
                              } else {
                                setState(() {
                                  buttonLoading = !buttonLoading;
                                  errorMsg = signIn;
                                });
                              }
                            } on FirebaseAuthException catch (_) {
                              setState(() {
                                buttonLoading = !buttonLoading;
                              });
                              // log(e.code);
                              // if (e.code == 'invalid-email') {
                              //   errorMsg = 'Email Address is Invalid';
                              //   if (e.code == 'user-not-found') {
                              //     errorMsg = 'User Not Found';
                              //   }
                              // } else {
                              //   errorMsg =
                              //       'OOps Something Went Wrong! : ${e.code}';
                              // }
                            }
                          },
                          color: CustomButtonColor.primary,
                          child: buttonLoading
                              ? const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black54,
                                      color: Colors.black87,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      letterSpacing: 0.8, color: Colors.black),
                                ),
                        ),
                      )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 2.0),
                      child: Text(
                        'Forgot Your Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/forgot-password');
                          },
                          child: const Text(
                            'Click Here',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w800),
                          )),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        height: .8,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Not Have an Account Yet?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: .8,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Center(
                    child: SizedBox(
                  height: 40,
                  width: screenSize.width * 0.6,
                  child: CustomButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    color: CustomButtonColor.dark,
                    child: const Text(
                      'Create New Account!',
                      style: TextStyle(letterSpacing: 0.8, color: Colors.black),
                    ),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
