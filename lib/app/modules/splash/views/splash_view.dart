import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: PRIMARY_COLOR),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/favicon.png",
                height: 300,
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}