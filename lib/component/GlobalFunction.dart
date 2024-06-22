import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:save_me/Pages/Signin/login.dart';
import 'package:save_me_new/component/MyText.dart';

final Color PRIMARY_COLOR = HexColor("#EB1C24");
final Color TEXT_COLOR = HexColor("#333333");
// Color SECONDARY_COLOR = HexColor("#F79F00");

var dio = Dio();

String BaseUrl = "http://192.168.1.16/save_me/";

double getLength(String type, BuildContext context) {
  var query = MediaQuery.of(context).size;

  return (type == "height") ? query.height : query.width;
}

// Future<String?> getToken({BuildContext? context}) async {
//   try {
//     var prefs = await SharedPreferences.getInstance();
//     var Token = await prefs.getString("Token");
//     print(Token);
//     return Token;
//   } catch (e) {
//     Navigator.pushReplacement(
//         context!,
//         MaterialPageRoute(
//           builder: (context) => LoginPage(),
//         ));
//     return "";
//   }
// }

getOption() {
  var myOptions = Options(headers: {
    "accept": "application/json",
  });

  return myOptions;
}

Future<dynamic> MyDialog(BuildContext context, {required String text}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Center(
        child: MyText(text),
      ),
    ),
  );
}

MySnackbar(BuildContext context, {required String text, Color? color, Color? textColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: MyText(text, color: textColor ?? Colors.white,),
      backgroundColor: color ?? Colors.green,
    ),
  );
}
