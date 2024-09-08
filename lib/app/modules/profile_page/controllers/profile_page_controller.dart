import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/models/app_feedback.dart';
import 'package:save_me_new/app/models/feedback.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/report_page/views/submit_success_page.dart';
import 'package:save_me_new/app/routes/app_pages.dart';

class ProfilePageController extends GetxController {
  TextEditingController message = TextEditingController();
  final auth = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String collectionName = 'report';
  String subcollectionName = 'feedback';
  List<FeedbackReport> allFeedbackReports = [];
  final count = 0.obs;

  void increment() => count.value++;
  Future<void> handleLogout() async {
    auth.signOut();
    Get.offAllNamed(Routes.AUTH_GATE);
  }

  Future<ImageProvider> getImageProvider(String filename) async {
    final ref = FirebaseStorage.instance.ref().child('Files/$filename');
    final downloadUrl = await ref.getDownloadURL();
    return NetworkImage(downloadUrl);
  }

  Future<void> addFeedback(int idReport, String message, String date,
      String name, String spesific) async {
    await FirebaseFirestore.instance
        .collection('report')
        .doc(idReport.toString())
        .collection('feedback')
        .add({
      'message': message,
      'date': date,
      'name': name,
      'spesific': spesific,
    });
    Get.offAll(const SubmitSuccessPage());
  }

  static Future<List<Report>> getReports() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection('report');
    List<Report> reports = [];
    try {
      QuerySnapshot querySnapshot = await collectionRef.get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        Report report = Report.fromDocument(doc); // Call static method
        reports.add(report);
      }
      return reports;
    } catch (e) {
      Get.defaultDialog(title: e.toString());
      return [];
    }
  }

  Future<List<FeedbackReport>> getFeedbacks() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<FeedbackReport> allFeedback = [];
    List<Report> reportsget = await getReports();
    try {
      for (Report report in reportsget) {
        DocumentReference reportDocRef =
            firestore.collection('report').doc(report.id.toString());
        print(reportDocRef);
        CollectionReference subcollection = reportDocRef.collection('feedback');
        QuerySnapshot feedDoc = await subcollection.get();
        for (DocumentSnapshot doc in feedDoc.docs) {
          FeedbackReport feedbackReport =
              FeedbackReport.fromDocument(doc); // Call static method
          allFeedback.add(feedbackReport);
        }
      }
      return allFeedback;
    } catch (e) {
      Get.defaultDialog(title: e.toString());
      return [];
    }
  }

  static Future<List<AppFeedback>> getAppFeedbacks() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<AppFeedback> allAppFeedback = [];
    CollectionReference collectionRef = firestore.collection('feedback2');
    try {
      QuerySnapshot querySnapshot = await collectionRef.get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        AppFeedback appFeedback = AppFeedback.fromDocument(doc); // Call static method
        allAppFeedback.add(appFeedback);
      }
      return allAppFeedback;
    } catch (e) {
      Get.defaultDialog(title: e.toString());
      return [];
    }
  }
}
