import 'package:cloud_firestore/cloud_firestore.dart';

class Webinar {
  late String title;
  late String dateTime;
  late String shortDesc;
  late String longDesc;
  late String filename;
  Webinar({
    required this.title,
    required this.dateTime,
    required this.shortDesc,
    required this.longDesc,
    required this.filename,
  });
  factory Webinar.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Webinar(
      title: data['title'],
      dateTime: data['dateTime'],
      shortDesc: data['shortDesc'],
      longDesc: data['longDesc'],
      filename: data['filename'],
    );
  }
}
