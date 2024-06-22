import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class Webinar {
  late String title;
  late String dateTime;
  late String shortDesc;
  late String longDesc;
  Webinar({
    required this.title,
    required this.dateTime,
    required this.shortDesc,
    required this.longDesc,
  });
  factory Webinar.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Webinar(
      title: data['title'],
      dateTime: data['dateTime'],
      shortDesc: data['shortDesc'],
      longDesc: data['longDesc'],
    );
  }
}
class WebinarPageController extends GetxController {
  //TODO: Implement WebinarPageController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
