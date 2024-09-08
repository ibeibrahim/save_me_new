import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class ShowFeedbackPage extends StatefulWidget {
  const ShowFeedbackPage({super.key});

  @override
  State<ShowFeedbackPage> createState() => _ShowFeedbackPageState();
}

class _ShowFeedbackPageState extends State<ShowFeedbackPage> {
  final feedbackController = TextEditingController();

  void sendFeedback() async {
    print(feedbackController.text);
    const uuid = Uuid();
    final fireStore = FirebaseFirestore.instance;
    CollectionReference feedback2 = fireStore.collection('feedback2');
    String newDocId = uuid.v4();
    Map<String, dynamic> data = {
      'docId': newDocId,
      'user_id': FirebaseAuth.instance.currentUser?.uid,
      'feedback': feedbackController.text
    };

    try {
      await feedback2.doc(newDocId).set(data);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil mengirim feedback'),
        ),
      );
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      Get.defaultDialog(title: e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Feedback untuk aplikasi',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('feedback2')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                print(streamSnapshot);
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: streamSnapshot.data?.docs.map<Widget>((doc) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(doc['']),
                                  Text(doc['feedback']),
                                ],
                              ),
                            ),
                          );
                        }).toList() ??
                        [], // Jika data tidak ada, gunakan list kosong
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    feedbackController.dispose();
    super.dispose();
  }
}
