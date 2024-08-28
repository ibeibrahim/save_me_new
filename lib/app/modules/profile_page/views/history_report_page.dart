import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:save_me_new/app/modules/profile_page/views/detail_history_report.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class HistoryReportPage extends StatelessWidget {
  const HistoryReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController controller = Get.put(ProfilePageController());
    final currentUser = controller.auth.getCurrentUser()!;
    return Scaffold(
      backgroundColor: Colors.white,
appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Text(
          'Save Me | Riwayat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('report')
              .where('email', isEqualTo: currentUser.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Report> reportList =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return Report.fromDocument(document);
            }).toList();
            return ListView.builder(
              itemCount: reportList.length,
              itemBuilder: (context, index) {
                Report reportItem = reportList[index];
                return Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        reportItem.nama,
                        style: kTitleTextStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            reportItem.spesifik,
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
                                    DetailHistoryReport(report: reportItem),
                                  );
                                },
                                child: const Text('Detail'),
                              ),
                              const SizedBox(width: 8),
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
}
