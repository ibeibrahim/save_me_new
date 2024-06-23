import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

import '../controllers/webinar_page_controller.dart';

class WebinarPageView extends GetView<WebinarPageController> {
  const WebinarPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Save Me | Webinar',
            style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('webinar').snapshots(),
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
                      shadowColor: PRIMARY_COLOR,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: FutureBuilder<ImageProvider>(
                              future: getImageProvider(webinar.filename),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    child: Image(
                                      image: snapshot.data!,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Icon(Icons.error);
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ),
                          // const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 10),
                            child: Text(
                              webinar.title,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            )));
  }

  Future<ImageProvider> getImageProvider(String filename) async {
    final ref = FirebaseStorage.instance.ref().child('webinar/$filename');
    final downloadUrl = await ref.getDownloadURL();

    return NetworkImage(downloadUrl);
  }
}
