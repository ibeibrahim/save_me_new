import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class FeedbackAdminPage extends StatefulWidget {
  const FeedbackAdminPage({super.key});

  @override
  State<FeedbackAdminPage> createState() => _FeedbackAdminPageState();
}

class _FeedbackAdminPageState extends State<FeedbackAdminPage> {
  ProfilePageController controller = Get.put(ProfilePageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: const Text(
          'Save Me | Feedback',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: ListView.builder(
          itemCount: controller.allFeedbackReports.length,
          itemBuilder: (context, index) {
            var itemFeedback = controller.allFeedbackReports[index];
            return Card(
                color: Colors.grey.shade100,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.3),
                        2: FractionColumnWidth(0.6)
                      },
                      children: [
                        TableRow(children: [
                          const Text(
                            'Name',
                            style: kTitleFeedbackTextStyle,
                          ),
                          const Text(
                            ':',
                            style: kTitleFeedbackTextStyle,
                          ),
                          Text(itemFeedback.name),
                        ]),
                        TableRow(children: [
                          const Text(
                            'Spesific',
                            style: kTitleFeedbackTextStyle,
                          ),
                          const Text(
                            ':',
                            style: kTitleFeedbackTextStyle,
                          ),
                          Text(itemFeedback.spesific),
                        ]),
                        TableRow(children: [
                          const Text(
                            'Message',
                            style: kTitleFeedbackTextStyle,
                          ),
                          const Text(
                            ':',
                            style: kTitleFeedbackTextStyle,
                          ),
                          Text(itemFeedback.message),
                        ]),
                        TableRow(children: [
                          const Text(
                            'Date',
                            style: kTitleFeedbackTextStyle,
                          ),
                          const Text(
                            ':',
                            style: kTitleFeedbackTextStyle,
                          ),
                          Text(itemFeedback.date),
                        ]),
                      ],
                    )));
          },
        ),
      ),
    );
  }
}
