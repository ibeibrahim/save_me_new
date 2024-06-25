import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 0.obs; // Use an observable for reactivity
  
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  NotchBottomBarController get barcontroller => _controller;
}
