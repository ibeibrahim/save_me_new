import 'package:flutter/material.dart';
import 'package:save_me_new/app/modules/home_layout/views/home_layout_view.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/my_text.dart';

class SubmitSuccessPage extends StatefulWidget {
  const SubmitSuccessPage({super.key});

  @override
  State<SubmitSuccessPage> createState() => _SubmitSuccessPageState();
}

class _SubmitSuccessPageState extends State<SubmitSuccessPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeLayoutView(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SizedBox(
        width: getLength("width", context),
        height: getLength("height", context),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.white,
            ),
            Mytext(
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
