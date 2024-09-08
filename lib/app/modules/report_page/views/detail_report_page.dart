import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/report_page/controllers/report_page_controller.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class DetailReportPage extends StatefulWidget {
  const DetailReportPage({
    super.key,
    required this.report,
  });
  final Report report;
  @override
  State<DetailReportPage> createState() => _DetailReportPageState();
}

class _DetailReportPageState extends State<DetailReportPage> {
  final ReportPageController controller = ReportPageController();
  late Report _report;
  @override
  void initState() {
    super.initState();
    _report = widget.report;
  }

  @override
  Widget build(BuildContext context) {
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
                 (_report.file != null) ? FutureBuilder<ImageProvider>(
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
                ): Container(),
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
                const SizedBox(height: 16),
                TextField(
                  controller: controller.result,
                  decoration: const InputDecoration(
                    labelText: 'Result',
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
                    int id = _report.id!;
                    String result = controller.result.text;
                    controller.finishReport(id, result);
                  },
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
