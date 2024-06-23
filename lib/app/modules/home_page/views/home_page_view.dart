import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/controllers/auth_controller.dart';
import 'package:save_me_new/component/berita_card.dart';

import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 112, 112),
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: ListView(
          children: const [
            BeritaCard(),
            SizedBox(
              height: 24,
            ),
            BeritaCard(),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
