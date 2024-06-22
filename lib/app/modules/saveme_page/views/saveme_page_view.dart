import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/saveme_page_controller.dart';

class SavemePageView extends GetView<SavemePageController> {
  const SavemePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SavemePageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SavemePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
