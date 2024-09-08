import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/report_page/views/detail_report_page.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

import '../controllers/report_page_controller.dart';

class ReportPageAdmin extends GetView<ReportPageController> {
  const ReportPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    // ReportPageController controller = Get.put(ReportPageController());
    return Scaffold(
      backgroundColor: Colors.white,
appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: Text(
          'Save Me | Report',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('report').snapshots(),
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
                                    DetailReportPage(report: reportItem),
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
