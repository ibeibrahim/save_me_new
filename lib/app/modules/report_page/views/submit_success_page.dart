import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:save_me_new/app/modules/home_layout/views/home_layout_view.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/MyText.dart';

class SubmitSuccessPage extends StatefulWidget {
  const SubmitSuccessPage({super.key});

  @override
  State<SubmitSuccessPage> createState() => _SubmitSuccessPageState();
}

class _SubmitSuccessPageState extends State<SubmitSuccessPage> {
  Color colorBlue = HexColor("#3671FF");

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeLayoutView(),));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlue,
      body: Container(
        width: getLength("width", context),
        height: getLength("height", context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.white,
            ),
            MyText(
              "Submit Successful",
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
