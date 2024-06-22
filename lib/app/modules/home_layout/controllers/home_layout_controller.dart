import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeLayoutController extends GetxController {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  PersistentTabController get controller => _controller;

  @override
  void onInit() {
    super.onInit();
    
    update(); // Update UI when controller is initialized
  }
}
