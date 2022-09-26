import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool obsecureText;
  final TextEditingController textEditingController;
  final String hintText;
  const CustomTextField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.obsecureText,
      required this.textEditingController});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String errorLabel = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   widget.title,
        //   style: const TextStyle(fontWeight: FontWeight.bold),
        // ),
        TextField(
          controller: widget.textEditingController,
          maxLines: 1,
          autocorrect: false,
          obscureText: widget.obsecureText,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(4)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange)),
              hintText: widget.hintText,
              labelText: widget.title,
              labelStyle: const TextStyle(color: Colors.grey)),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            if (widget.title.toLowerCase() == 'email' &&
                !value.contains('@') &&
                value.isNotEmpty) {
              setState(() {
                errorLabel = 'Please Enter Valid EmailAddress';
              });
            } else {
              setState(() {
                errorLabel = '';
              });
            }
          },
        ),
        Text(
          errorLabel,
          style: const TextStyle(color: Colors.red),
        )
      ],
    );
  }
}
