import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:save_me_new/app/models/app_feedback.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

class ShowFeedbackPage extends StatefulWidget {
  const ShowFeedbackPage({super.key});

  @override
  State<ShowFeedbackPage> createState() => _ShowFeedbackPageState();
}

class _ShowFeedbackPageState extends State<ShowFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: const Text(
          'Save Me | App Feedback',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('feedback2').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List<AppFeedback> appFeedbackList =
                snapshot.data!.docs.map((DocumentSnapshot document) {
              return AppFeedback.fromDocument(document);
            }).toList();
            return ListView.builder(
              itemCount: appFeedbackList.length,
              itemBuilder: (context, index) {
                AppFeedback appFeedback = appFeedbackList[index];
                return Card(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(
                        appFeedback.message,
                        style: kTitleFeedbackTextStyle,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'User ID : ${appFeedback.userId}',
                            style: kSubtitleFeedbackTextStyle,
                          ),
                          Text(
                            'Doc ID : ${appFeedback.docId}',
                            style: kSubtitleFeedbackTextStyle,
                          ),
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
