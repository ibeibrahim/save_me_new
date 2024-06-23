import 'package:flutter/material.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/theme.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obsecureText,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obsecureText,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PRIMARY_COLOR),
          ),
          fillColor: PRIMARY_COLOR,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
