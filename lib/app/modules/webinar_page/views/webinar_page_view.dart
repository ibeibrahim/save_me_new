import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/webinar_page/views/detail_webinar_page.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/component/GlobalFunction.dart';
import '../controllers/webinar_page_controller.dart';

class WebinarPageView extends GetView<WebinarPageController> {
  WebinarPageView({super.key});

  void handleDaftarWebinar() {
    // TODO: Implement HandleDaftarWebinar
  }
  void handleDeleteWebinar() {
    // TODO: Implement HandleDeleteWebinar
  }
  void handleAddWebinar() {
    // TODO: Implement HandleDeleteWebinar
  }
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    bool showDeleteButton = false;
    bool showDaftarButton = true;
    if (_authService.getCurretUser()!.email == 'admin@gmail.com') {
      showDeleteButton = true;
      showDaftarButton = false;
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
                // handle the press
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SECONDARY_COLOR),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(webinar.shortDesc),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PRIMARY_COLOR,
                                  foregroundColor: kTextColor,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => DetailWebinarPage(
                                        webinar: webinar,
                                      ),
                                    ),
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
                                  onPressed: handleDeleteWebinar,
                                  child: const Text('Delete'),
                                ),
                              ),
                              Visibility(
                                visible: showDaftarButton,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: SECONDARY_COLOR,
                                      foregroundColor: kTextColor),
                                  onPressed: handleDaftarWebinar,
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
