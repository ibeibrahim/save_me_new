import 'dart:async';

import 'package:get/get.dart';
import 'package:save_me_new/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    loading();
  }

  Future<void> loading() async {
    Timer(Duration(seconds: 3), () {
      Get.offAndToNamed(Routes.AUTH_GATE);
    });
  }

}