import 'package:flutter/material.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/MyText.dart';
import 'package:save_me_new/component/theme.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    this.width,
    this.height,
    this.backgroundColor,
    required this.onPressed,
    required this.text,
  });
  double? width;
  double? height;
  Color? backgroundColor;
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? getLength("width", context),
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Heading1(
          text,
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
