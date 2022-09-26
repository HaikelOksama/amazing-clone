import 'dart:ui';

import 'package:amazon/utils/constant.dart';
import 'package:amazon/utils/utility.dart';
import 'package:amazon/widgets/custom_button.dart';
import 'package:amazon/widgets/text_field.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = Utils().getScreenSize();
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
                          child: SizedBox(
                        height: 40,
                        width: screenSize.width * 0.5,
                        child: CustomButton(
                          onPressed: () {},
                          color: CustomButtonColor.primary,
                          child: const Text(
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
