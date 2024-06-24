import 'package:flutter/material.dart';


class Mytext extends StatelessWidget {
  const Mytext(
    this.text, {
    this.color,
    this.fontSize,
    this.textAlign,
    this.fontWeight,
    super.key,
  });
  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: myTextStyle(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class Heading1 extends StatelessWidget {
  const Heading1(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    super.key,
  });
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? Colors.black,
        fontFamily: "Nunito",
        fontSize: fontSize ?? 32.0,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}

myTextStyle({color, double? fontSize, fontWeight}) {
  return TextStyle(
      fontFamily: "Nunito",
      color: color ?? Colors.grey,
      fontSize: fontSize ?? 12.0,
      fontWeight: fontWeight ?? FontWeight.normal);
}
