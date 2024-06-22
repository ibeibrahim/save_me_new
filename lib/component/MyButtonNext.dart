import 'package:flutter/material.dart';
import 'package:save_me_new/component/MyText.dart';
import 'package:save_me_new/component/theme.dart';


class MyButtonNext extends StatefulWidget {
  MyButtonNext({
    super.key,
    this.width,
    required this.onPressed,
    required this.text,
    this.color
  });
  double? width;
  final void Function() onPressed;
  final String text;
  Color? color;

  @override
  State<MyButtonNext> createState() => _MyButtonNextState();
}

class _MyButtonNextState extends State<MyButtonNext> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          
          backgroundColor: widget.color?? buttonPrimary,

          shape: RoundedRectangleBorder(
            
           borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Heading1(
          widget.text,
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
