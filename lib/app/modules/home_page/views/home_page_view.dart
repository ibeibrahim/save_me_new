import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/controllers/auth_controller.dart';

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
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/kompasimg.png",
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "2017 Ada 12 Kasus Pelecehan Seksual di KRL",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/kompasicon.png",
                      width: 10,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Kompas.com"),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "assets/images/verified.png",
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: authController.handleLogout,
                  child: const Text('logout'),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/kompasimg.png"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "2017 Ada 12 Kasus Pelecehan Seksual di KRL",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/kompasicon.png",
                      width: 10,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Kompas.com"),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "assets/images/verified.png",
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: authController.handleLogout,
                  child: const Text('logout'),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/kompasimg.png"),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "2017 Ada 12 Kasus Pelecehan Seksual di KRL",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/kompasicon.png",
                      width: 10,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Kompas.com"),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      "assets/images/verified.png",
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: authController.handleLogout,
                  child: const Text('logout'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
