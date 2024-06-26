import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:save_me/Pages/Signin/login.dart';
import 'package:save_me_new/component/my_text.dart';

final Color PRIMARY_COLOR = HexColor("#C80036");
final Color kTextColor = HexColor("#FFF5E1");
final Color SECONDARY_COLOR = HexColor("#0C1844");
final Color accentColor = HexColor('#FF6969');
// API KEY FOR NEWS API
// const String newsAPIKey = "7f61ddf46fe3400fbf08926f2c2e1549";
const kTitleTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kTitleFeedbackTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kLongDescTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
);
const kShortDescTextStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black54,
);
// API KEY FOR WORLDNEWSAPI
const String newsAPIKey = "0ac22b17b95a4fcdb37fed31cf82917f";

const String placeHolderImageLink =
    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";
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
        child: Mytext(text),
      ),
    ),
  );
}

mySnackBar(BuildContext context,
    {required String text, Color? color, Color? textColor}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Mytext(
        text,
        color: textColor ?? Colors.white,
      ),
      backgroundColor: color ?? Colors.green,
    ),
  );
}
