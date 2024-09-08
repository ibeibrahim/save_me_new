import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:save_me_new/app/models/report.dart';
import 'package:save_me_new/app/modules/report_page/views/submit_success_page.dart';

class ReportPageController extends GetxController {
  // TextEditingController emailController = TextEditingController();
  TextEditingController telephoneNumber = TextEditingController();
  TextEditingController nameOfCompainant = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController homeaddress = TextEditingController();
  TextEditingController spesific = TextEditingController();
  TextEditingController result = TextEditingController();
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

  Future<ImageProvider> getImageProvider(String filename) async {
    final ref = FirebaseStorage.instance.ref().child('Files/$filename');
    final downloadUrl = await ref.getDownloadURL();
    return NetworkImage(downloadUrl);
  }

  Future<int> getDocumentCount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('report');
    AggregateQuerySnapshot aggregateQuerySnapshot =
        await collection.count().get(source: AggregateSource.server);
    if (aggregateQuerySnapshot.count == 0) {
      return 0;
    }
    int count = aggregateQuerySnapshot.count!;
    return count;
  }

  void addReport(Report newReport) {
    String newDocId = newReport.id.toString();
    DocumentReference newDocRef =
        FirebaseFirestore.instance.collection('report').doc(newDocId);
    newDocRef.set({'exist': true}).onError(
        (e, _) => print("Error writing document: $e"));
    Future.delayed(const Duration(seconds: 1));
    FirebaseFirestore.instance.collection('report').doc(newDocId).set({
      'id': newReport.id,
      'uid': newReport.uid,
      'nama': newReport.nama,
      'telepon': newReport.telepon,
      // 'email': newReport.email,
      'umur': newReport.umur,
      'jenisKelamin': newReport.jenisKelamin,
      'alamat': newReport.alamat,
      'spesifik': newReport.spesifik,
      'file': newReport.file,
      'status': newReport.status,
      'result': newReport.result,
    });
    Get.offAll(const SubmitSuccessPage());
  }

  Future<void> finishReport(int id, String result) async {
    await FirebaseFirestore.instance
        .collection('report')
        .doc(id.toString())
        .update({
      'result': result,
      'status': 'finish',
    });
    Get.offAll(const SubmitSuccessPage());
  }
}
