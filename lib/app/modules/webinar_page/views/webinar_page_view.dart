import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/webinar_page/views/detail_webinar_page.dart';

import '../controllers/webinar_page_controller.dart';

class WebinarPageView extends GetView<WebinarPageController> {
  const WebinarPageView({super.key});

  Future<void> handleDaftarWebinar() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WebinarPageView'),
          centerTitle: true,
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
                      child: ListTile(
                        title: Text(webinar.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(webinar.shortDesc),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => DetailWebinarPage(
                                            title: webinar.title,
                                            longDescription: webinar.longDesc),
                                      ),
                                    );
                                  },
                                  child: const Text('Detail'),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[100],
                                      foregroundColor: Colors.black),
                                  onPressed: handleDaftarWebinar,
                                  child: const Text('Daftar'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )));
  }
}
