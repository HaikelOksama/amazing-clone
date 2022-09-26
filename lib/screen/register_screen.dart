import 'dart:ui';

import 'package:amazon/utils/constant.dart';
import 'package:amazon/utils/utility.dart';
import 'package:amazon/widgets/custom_button.dart';
import 'package:amazon/widgets/text_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  late final TextEditingController _address;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _address = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _address.dispose();
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                ),
                Container(
                  width: screenSize.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Sign-Up',
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.w300),
                        ),
                      ),
                      CustomTextField(
                          title: 'Name',
                          obsecureText: false,
                          hintText: 'Enter Your Name',
                          textEditingController: _name),
                      CustomTextField(
                          title: 'Address',
                          obsecureText: false,
                          hintText: 'Enter Your Address',
                          textEditingController: _address),
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
                            'Sign Up',
                            style: TextStyle(
                                letterSpacing: 0.8, color: Colors.black),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Center(
                      child: SizedBox(
                    height: 40,
                    width: screenSize.width * 0.6,
                    child: CustomButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: CustomButtonColor.secondary,
                      child: const Text(
                        'Back To Login',
                        style: TextStyle(
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
