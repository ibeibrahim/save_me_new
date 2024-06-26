import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/webinar_page/views/detail_webinar_page.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/app/modules/webinar_page/views/webinar_add_page.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import '../controllers/webinar_page_controller.dart';

class WebinarPageView extends GetView<WebinarPageController> {
  WebinarPageView({super.key});

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final WebinarPageController webinarPageController = WebinarPageController();
    bool showDeleteButton = false;
    bool showDaftarButton = true;
    bool showAdminButton = false;
    if (_authService.getCurrentUser()!.email == 'admin@gmail.com') {
      showDeleteButton = true;
      showDaftarButton = false;
      showAdminButton = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Webinar',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
        actions: [
          Visibility(
            visible: showDeleteButton,
            child: IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add Webinar',
              onPressed: () {
                Get.to(() => const WebinarAddPage());
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('webinar').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Webinar> webinarList =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return Webinar.fromDocument(document);
            }).toList();
            return ListView.builder(
              itemCount: webinarList.length,
              itemBuilder: (context, index) {
                Webinar webinar = webinarList[index];
                return Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        webinar.title,
                        style: kTitleTextStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            webinar.shortDesc,
                            style: kShortDescTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PRIMARY_COLOR,
                                  foregroundColor: kTextColor,
                                ),
                                onPressed: () {
                                  Get.to(
                                    DetailWebinarPage(webinar: webinar),
                                    arguments: {'button': showAdminButton},
                                  );
                                },
                                child: const Text('Detail'),
                              ),
                              const SizedBox(width: 8),
                              Visibility(
                                visible: showDeleteButton,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: SECONDARY_COLOR,
                                      foregroundColor: kTextColor),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      middleText: 'Are you sure ?',
                                      textConfirm: 'Delete',
                                      onConfirm: () async {
                                        await webinarPageController
                                            .deleteWebinar(webinar.docId);
                                        Get.back();
                                      },
                                      onCancel: () => Get.back(),
                                      textCancel: 'Cancel',
                                      backgroundColor: Colors.white,
                                      buttonColor: PRIMARY_COLOR,
                                    );
                                  },
                                  child: const Text('Delete'),
                                ),
                              ),
                              Visibility(
                                visible: showDaftarButton,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: SECONDARY_COLOR,
                                      foregroundColor: kTextColor),
                                  onPressed: () {
                                    String uid =
                                        _authService.getCurrentUser()!.uid;
                                    String webinarId = webinar.docId;
                                    webinarPageController.registerWebinar(
                                        uid, webinarId);
                                  },
                                  child: const Text('Daftar'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<ImageProvider> getImageProvider(String filename) async {
    final ref = FirebaseStorage.instance.ref().child('webinar/$filename');
    final downloadUrl = await ref.getDownloadURL();

    return NetworkImage(downloadUrl);
  }
}
