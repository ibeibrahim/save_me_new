import 'package:get/get.dart';

import '../controllers/saveme_page_controller.dart';

class SavemePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SavemePageController>(
      () => SavemePageController(),
    );
  }
}
