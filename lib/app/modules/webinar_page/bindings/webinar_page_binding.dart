import 'package:get/get.dart';

import '../controllers/webinar_page_controller.dart';

class WebinarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebinarPageController>(
      () => WebinarPageController(),
    );
  }
}
