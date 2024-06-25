import 'package:cloud_firestore/cloud_firestore.dart';

class Webinar {
  late String id;
  late String docId;
  late String title;
  late String dateTime;
  late String shortDesc;
  late String longDesc;
  late String filename;
  late String time;
  Webinar({
    required this.id,
    required this.docId,
    required this.title,
    required this.dateTime,
    required this.shortDesc,
    required this.longDesc,
    required this.filename,
    required this.time,
  });
  factory Webinar.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Webinar(
      id: data['id'].toString(),
      docId: data['docId'],
      title: data['title'],
      dateTime: data['dateTime'],
      shortDesc: data['shortDesc'],
      longDesc: data['longDesc'],
      filename: data['filename'],
      time: data['time'],
    );
  }
}
