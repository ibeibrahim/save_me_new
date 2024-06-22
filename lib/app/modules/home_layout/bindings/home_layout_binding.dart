import 'package:get/get.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../controllers/home_layout_controller.dart';

class HomeLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeLayoutController>(
      () => HomeLayoutController(),
    );
    Get.put<PersistentTabController>(PersistentTabController(initialIndex: 0));
  }
}
