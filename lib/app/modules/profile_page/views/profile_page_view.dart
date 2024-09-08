import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:save_me_new/app/modules/profile_page/views/feedback/add_feedback_page.dart';
import 'package:save_me_new/app/modules/profile_page/views/feedback/show_feedback_page.dart';
import 'package:save_me_new/app/modules/profile_page/views/feedback_admin_page.dart';
import 'package:save_me_new/app/modules/profile_page/views/history_report_page.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import 'package:save_me_new/component/my_text.dart';

import '../controllers/profile_page_controller.dart';

Color greyColor = HexColor("#F5F5F5");

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.put(ProfilePageController());
    bool isUser = true;
    if (controller.auth.getCurrentUser()!.email == 'admin@gmail.com') {
      isUser = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: const Text(
          'Save Me | Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                  const Expanded(
                    child: ProfilePictureWidget(),
                  ),
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
              visible: isUser,
              child: MenuProfile(
                text: "Beri Masukan",
                onTap: () {
                  Get.to(const AddFeedbackPage());
                },
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: !isUser,
              child: MenuProfile(
                text: "Feedback",
                onTap: () async {
                  controller.allFeedbackReports =
                      await controller.getFeedbacks();
                  Get.to(() => const FeedbackAdminPage());
                },
              ),
            ),
            const SizedBox(height: 12),
            Visibility(
              visible: !isUser,
              child: MenuProfile(
                text: "Feedback terhadap aplikasi",
                onTap: () async {
                  Get.to(() => const ShowFeedbackPage());
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

class ProfilePictureWidget extends StatefulWidget {
  const ProfilePictureWidget({super.key});

  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  void changeImageProfil() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File fileToUpload = File(result.files.single.path!);
        String fileName =
            "${FirebaseAuth.instance.currentUser!.uid}.${fileToUpload.path.split('.').last}";

        print(fileName);
        firebase_storage.Reference ref =
            _storage.ref().child('profile').child(fileName);
        await ref.putFile(fileToUpload);
        Get.defaultDialog(title: 'File uploaded successfully');
        setState(() {});
      } else {
        // User canceled file picking
      }
    } catch (e) {
      Get.defaultDialog(title: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: changeImageProfil,
      child: FutureBuilder(
          future: showImageProfile(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            final url = snapshot.data;
            if (url == null || url == '') {
              return Container(
                  width: 80,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/sumguy.png"),
                    ),
                  ));
            } else {
              return Container(
                width: 80,
                height: 80,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(url),
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<String> showImageProfile() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      final ref = _storage.ref("profile/$userId.jpg");
      await ref.getMetadata();

      return ref.getDownloadURL();
    } catch (e) {
      print(e);
    }

    try {
      final ref = _storage.ref("profile/$userId.jpeg");
      await ref.getMetadata();

      return ref.getDownloadURL();
    } catch (e) {
      print(e);
    }

    try {
      final ref = _storage.ref("profile/$userId.png");
      await ref.getMetadata();

      return ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
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
