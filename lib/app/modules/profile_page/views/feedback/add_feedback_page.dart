import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AddFeedbackPage extends StatefulWidget {
  const AddFeedbackPage({super.key});

  @override
  State<AddFeedbackPage> createState() => _AddFeedbackPageState();
}

class _AddFeedbackPageState extends State<AddFeedbackPage> {
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
          'Beri feedback untuk aplikasi ini',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: feedbackController,
                  maxLines: 8, //or null
                  decoration: const InputDecoration.collapsed(
                    hintText: "Enter your text here",
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: sendFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
              ),
              child: const Text(
                "Kirim",
                style: TextStyle(color: Colors.white),
              ),
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
