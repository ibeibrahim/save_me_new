import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class DetailHistoryReport extends StatefulWidget {
  const DetailHistoryReport({
    super.key,
    required this.report,
  });
  final Report report;
  @override
  State<DetailHistoryReport> createState() => _DetailHistoryReportState();
}

class _DetailHistoryReportState extends State<DetailHistoryReport> {
  final ProfilePageController controller = ProfilePageController();
  late Report _report;
  @override
  void initState() {
    super.initState();
    _report = widget.report;
  }

  @override
  Widget build(BuildContext context) {
    bool statusProcess = false;
    if (_report.status == "finish") {
      statusProcess = true;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: Text(
          'Save Me | Report Detail',
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (_report.file != null)
                    ? FutureBuilder<ImageProvider>(
                        future: controller.getImageProvider(_report.file!),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: Image(
                                image: snapshot.data!,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Icon(Icons.error);
                          } else {
                            return const Text('Loading...');
                          }
                        },
                      )
                    : Container(),
                const SizedBox(height: 16),
                // Text(
                //   'Email : ${_report.email}',
                //   style: kTitleTextStyle,
                // ),
                Text(
                  'Name : ${_report.nama}',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Gender : ${_report.jenisKelamin}',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Age : ${_report.umur}',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Contact : ${_report.telepon}',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Address : ${_report.alamat}',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Spesific : ${_report.spesifik}',
                  style: kTitleTextStyle,
                ),
                Text(
                  'Status : ${_report.status}',
                  style: kTitleTextStyle,
                ),
                Visibility(
                  visible: statusProcess,
                  child: Text(
                    'Result : ${_report.result}',
                    style: kTitleTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: statusProcess,
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.message,
                        decoration: const InputDecoration(
                          labelText: 'Feedback',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          foregroundColor: kTextColor,
                        ),
                        onPressed: () {
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('MMMM dd, yyyy').format(now);
                          String message = controller.message.text;
                          controller.addFeedback(
                            _report.id!,
                            message,
                            formattedDate,
                            _report.nama,
                            _report.spesifik,
                          );
                        },
                        child: const Text('Send Feedback'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
