import 'package:amazon/utils/alert_dialog.dart';
import 'package:amazon/utils/utility.dart';
import 'package:amazon/widgets/custom_button.dart';
import 'package:amazon/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  late final TextEditingController _email;

  @override
  void initState() {
    _email = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  bool buttonLoading = false;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Reset Password'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
          child: Container(
            height: screenSize.height * 0.5,
            width: screenSize.width * 0.8,
            padding: const EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text('Provide Your Email Address'),
                ),
                CustomTextField(
                  hintText: 'Your Email Address',
                  title: 'Email',
                  obsecureText: false,
                  textEditingController: _email,
                ),
                SizedBox(
                  height: 40,
                  width: screenSize.width * 0.4,
                  child: CustomButton(
                    onPressed: () async {
                      if (_email.text.isNotEmpty) {
                        try {
                          setState(() {
                            buttonLoading = !buttonLoading;
                          });
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _email.text.trim());
                          await showCustomDialog(
                              context: context,
                              title: 'Success',
                              content: 'Please Check Yo Email and Follow thru',
                              action: () => Navigator.of(context)
                                  .pushReplacementNamed('/login'));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Yo Email Not Right'),
                            ));
                          } else if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'This Email Is Not Registered Yet!')));
                          } else {
                            await showCustomDialog(
                                context: context,
                                title: 'Something Went Wrong!',
                                content: e.code.toString(),
                                action: () => Navigator.pop(context));
                          }

                          setState(() {
                            buttonLoading = !buttonLoading;
                          });
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Enter Yo Email')));
                      }
                    },
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
                            'Reset Password',
                            style: TextStyle(
                                letterSpacing: 0.8,
                                color: Colors.black87,
                                fontSize: 13),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
