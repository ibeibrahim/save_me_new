import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.red),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Splash Screen',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                'yeah',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}