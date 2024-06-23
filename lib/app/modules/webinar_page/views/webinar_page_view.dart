import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          stream: FirebaseFirestore.instance.collection('webinar').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Webinar> webinarList = snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                return Webinar.fromDocument(document);
              },
            ).toList();
            return ListView.builder(
              itemCount: webinarList.length,
              itemBuilder: (context, index) {
                Webinar webinar = webinarList[index];
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey[300]!,
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Text(
                          webinar.title,
                          style: const TextStyle(fontSize: 20),
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
                                    backgroundColor: Colors.orange[50],
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Detail'),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[100],
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {},
                                  child: const Text('Daftar'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
