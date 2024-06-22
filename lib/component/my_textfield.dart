import 'package:flutter/material.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/theme.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  const MyTextField(
      {super.key,
      required this.hintText,
      required this.obsecureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PRIMARY_COLOR),
          ),
          fillColor: Colors.red.shade100,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black45),
        ),
      ),
    );
  }
}
