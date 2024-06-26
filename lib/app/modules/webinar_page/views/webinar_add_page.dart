import 'package:flutter/material.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/app/modules/webinar_page/controllers/webinar_page_controller.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class WebinarAddPage extends StatelessWidget {
  const WebinarAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    WebinarPageController controller = WebinarPageController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Save Me | Add Webinar',
          style: TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: controller.shortDescController,
              decoration: const InputDecoration(labelText: 'Short Description'),
            ),
            TextField(
              controller: controller.longDescController,
              decoration: const InputDecoration(labelText: 'Long Description'),
            ),
            TextField(
              controller: controller.dateTimeController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: controller.timeController,
              decoration: const InputDecoration(labelText: 'Time'),
            ),
            const SizedBox(height: 20),
            const Text('Choose File Photo'),
            IconButton(
              icon: const Icon(Icons.upload_file),
              onPressed: controller.chooseFile,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                foregroundColor: kTextColor,
              ),
              onPressed: () async {
                String inputTitle = controller.titleController.text.trim();
                String inputShortDesc =
                    controller.shortDescController.text.trim();
                String inputLongDesc =
                    controller.longDescController.text.trim();
                String inputDateTime = controller.dateTimeController.text;
                String inputTime = controller.timeController.text;
                String file = controller.filename;
                await controller.getDocumentCount();
                int docCount = controller.doc + 1;
                String docId = '$docCount';
                if (inputTitle.isNotEmpty &&
                    inputShortDesc.isNotEmpty &&
                    inputLongDesc.isNotEmpty &&
                    inputDateTime.isNotEmpty &&
                    inputTime.isNotEmpty &&
                    file.isNotEmpty) {
                  Webinar newWebinar = Webinar(
                    id: docId,
                    docId: docId,
                    title: inputTitle,
                    dateTime: inputDateTime,
                    shortDesc: inputShortDesc,
                    longDesc: inputLongDesc,
                    filename: file,
                    time: inputTime,
                  );
                  controller.addWebinar(newWebinar);
                } else {
                  mySnackBar(
                    context,
                    text: "Fill in all forms",
                    color: PRIMARY_COLOR,
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
