import 'package:cloud_firestore/cloud_firestore.dart';

class AppFeedback {
  late String docId;
  late String userId;
  late String message;
  AppFeedback({
    required this.docId,
    required this.userId,
    required this.message,
  });

  factory AppFeedback.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return AppFeedback(
      docId: data['docId'],
      userId: data['user_id'],
      message: data['feedback'],
    );
  }
}
