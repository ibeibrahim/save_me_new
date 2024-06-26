import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:save_me_new/app/modules/profile_page/views/feedback_admin_page.dart';
import 'package:save_me_new/app/modules/profile_page/views/history_report_page.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/my_text.dart';

import '../controllers/profile_page_controller.dart';

Color greyColor = HexColor("#F5F5F5");

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.put(ProfilePageController());
    bool isUser = true;
    if (controller.auth.getCurrentUser()!.email == 'admin@gmail.com') {
      isUser = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Profile',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: greyColor,
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(child: Image.asset("assets/images/sumguy.png")),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Mytext(
                          controller.auth.getCurrentUser()!.email ?? '',
                          fontSize: 18,
                        ),
                        const Mytext(
                          "Bandung, Indonesia",
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 12),
            // const MenuProfile(
            //   text: "Setting",
            // ),
            const SizedBox(height: 12),
            Visibility(
              visible: isUser,
              child: MenuProfile(
                text: "Riwayat Laporan",
                onTap: () {
                  Get.to(const HistoryReportPage());
                },
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: !isUser,
              child: MenuProfile(
                text: "Feedback",
                onTap: () async {
                  controller.allFeedbackReports = await controller.getFeedbacks();
                  print('CONTROLLER ALL REPORT : ${controller.allFeedbackReports}');
                  Get.to(() => const FeedbackAdminPage());
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: PRIMARY_COLOR,
                ),
                onPressed: controller.handleLogout,
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: 150,
      color: Colors.grey,
    );
  }
}

class MenuProfile extends StatelessWidget {
  const MenuProfile({
    super.key,
    required this.text,
    required this.onTap,
  });
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getLength("width", context),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(3, 3),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Mytext(
            text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
