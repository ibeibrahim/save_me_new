import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:save_me_new/component/GlobalFunction.dart';


String MoneyText(dynamic value) {
  if (value is num) {
    final rupiahFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return rupiahFormatter.format(value);
  } else {
    return 'Invalid value';
  }
}

class MyText extends StatelessWidget {
  MyText(
    this.text, {
    this.color,
    this.fontSize,
    this.textAlign,
    this.fontWeight,
    super.key,
  });
  final String text;
  Color? color;
  double? fontSize;
  TextAlign? textAlign;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: MyTextStyle(
        color: color ?? TEXT_COLOR,
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}

class Heading1 extends StatelessWidget {
  Heading1(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    super.key,
  });
  final String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;

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

MyTextStyle({color, double? fontSize, fontWeight}) {
  return TextStyle(
      fontFamily: "Nunito",
      color: color ?? Colors.grey,
      fontSize: fontSize ?? 12.0,
      fontWeight: fontWeight ?? FontWeight.normal);
}
