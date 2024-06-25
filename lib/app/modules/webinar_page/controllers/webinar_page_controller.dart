import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  Future<ImageProvider> getImageProvider(String filename) async {
    final ref = FirebaseStorage.instance.ref().child('webinar/$filename');
    final downloadUrl = await ref.getDownloadURL();

    return NetworkImage(downloadUrl);
  }
}
