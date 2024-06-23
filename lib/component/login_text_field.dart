import 'package:flutter/material.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.controller,
    required this.obscureText,
    this.color,
    this.validator,
    this.height,
    this.enabled,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Color? color;
  final double? height;
  final bool? enabled;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: getLength("width", context),
      height: widget.height ?? 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.color ?? Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ]),
      child: TextFormField(
        validator: widget.validator,
        enabled: widget.enabled ?? true,
        obscureText: widget.obscureText,
        controller: widget.controller,
        maxLines: (widget.obscureText == true) ? 1 : null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          
        ),
      ),
    );
  }
}
