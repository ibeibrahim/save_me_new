import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_me_new/app/models/webinar.dart';
import 'package:save_me_new/app/modules/report_page/views/submit_success_page.dart';

class WebinarPageController extends GetxController {
  final TextEditingController idController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescController = TextEditingController();
  final TextEditingController longDescController = TextEditingController();
  final TextEditingController dateTimeController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String filename = '';
  int doc = 0;
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

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

  Future<ImageProvider> getImageProvider(String filename) async {
    final ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('webinar/$filename');
    final downloadUrl = await ref.getDownloadURL();

    return NetworkImage(downloadUrl);
  }

  Future<int> getDocumentCount() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('webinar');
    // Use count() aggregation query
    AggregateQuerySnapshot aggregateQuerySnapshot =
        await collection.count().get(source: AggregateSource.server);
    doc = aggregateQuerySnapshot.count!;
    print('DOC COUNT : $doc');
    // Return the document count
    return doc;
  }

  Future<void> chooseFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        File fileToUpload = File(result.files.single.path!);
        String fileName =
            'file_${DateTime.now().millisecondsSinceEpoch}${fileToUpload.path.split('/').last}';
        firebase_storage.Reference ref =
            _storage.ref().child('webinar').child(fileName);
        filename = fileName;
        await ref.putFile(fileToUpload);
        print('File uploaded successfully!');
      } else {
        // User canceled file picking
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  Future<void> addWebinar(Webinar addWebinar) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference webinars = firestore.collection('webinar');
    DocumentReference newDocRef = webinars.doc(addWebinar.id);
    // await newDocRef.set({'exist': true}).onError(
    //     (e, _) => print("Error writing document: $e"));

    Map<String, dynamic> webinarData = {
      'id': newDocRef,
      'docId': addWebinar.docId,
      'title': addWebinar.title,
      'shortDesc': addWebinar.shortDesc,
      'longDesc': addWebinar.longDesc,
      'time': addWebinar.time,
      'dateTime': addWebinar.dateTime,
      'filename': addWebinar.filename,
    };
    try {
      await webinars.doc(addWebinar.id).set(webinarData);
      print('SUCCESS CREATE WEBIINAR');
      // User document created successfully
    } on FirebaseException catch (e) {
      // Handle errors
      print(e.message);
    }
    Get.offAll(const SubmitSuccessPage());
  }

  Future<void> deleteWebinar(String id) async {
    FirebaseFirestore.instance.collection('webinar').doc(id).delete();
  }
}
