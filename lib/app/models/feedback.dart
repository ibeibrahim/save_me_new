import 'package:cloud_firestore/cloud_firestore.dart';
class FeedbackReport {
  late String date;
  late String message;
  late String name;
  late String spesific;
  FeedbackReport({
    required this.date,
    required this.message,
    required this.name,
    required this.spesific,
  });
  factory FeedbackReport.fromDocument(
      DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return FeedbackReport(
      date: data['date'],
      message: data['message'],
      name: data['name'],
      spesific: data['spesific'],
    );
  }
}
