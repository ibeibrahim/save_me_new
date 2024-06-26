import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/home_page/views/home_page_view.dart';
import 'package:save_me_new/app/modules/profile_page/views/profile_page_view.dart';
import 'package:save_me_new/app/modules/report_page/views/report_page_admin.dart';
import 'package:save_me_new/app/modules/report_page/views/report_page_view.dart';
import 'package:save_me_new/app/modules/saveme_page/views/admin_page_view.dart';
import 'package:save_me_new/app/modules/saveme_page/views/saveme_page_view.dart';
import 'package:save_me_new/app/modules/webinar_page/views/webinar_page_view.dart';
import 'package:save_me_new/component/GlobalFunction.dart';

import '../controllers/home_layout_controller.dart';

class HomeLayoutView extends GetView<HomeLayoutController> {
  HomeLayoutView({super.key}) {
    Get.lazyPut<HomeLayoutController>(
      () => HomeLayoutController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Wrapper(),
    );
  }
}

class Wrapper extends GetWidget<HomeLayoutController> {
  Wrapper({super.key});
  final int maxCount = 5;
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeLayoutController>(
      () => HomeLayoutController(),
    );
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            _buildScreens().length, (index) => _buildScreens()[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (_buildScreens().length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,
              notchColor: SECONDARY_COLOR,
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),
              bottomBarItems: _navNotchBarItems(),
              onTap: (index) {
                log('current selected index $index');
                controller.currentIndex.value = index;
                controller.pageController.jumpToPage(index);
                // HomeLayoutController().pagecontroller.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}

List<Widget> _buildScreens() {
  final AuthService authService = AuthService();
  final currentUser = authService.getCurrentUser();
  // return for admin
  if (currentUser?.email == 'admin@gmail.com') {
    return [
      HomePageView(),
      WebinarPageView(),
      const ReportPageAdmin(),
      AdminPageView(),
      const ProfilePageView(),
    ];
  }
  // return for user
  return [
    HomePageView(),
    WebinarPageView(),
    const ReportPageView(),
    SavemePageView(),
    const ProfilePageView(),
  ];
}

List<BottomBarItem> _navNotchBarItems() {
  return [
    BottomBarItem(
      inActiveItem: Icon(
        Icons.home,
        color: Colors.grey.shade400,
      ),
      activeItem: Icon(
        Icons.home,
        color: PRIMARY_COLOR,
      ),
      itemLabel: 'Home',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.slideshow,
        color: Colors.grey.shade400,
      ),
      activeItem: Icon(
        Icons.slideshow,
        color: PRIMARY_COLOR,
      ),
      itemLabel: 'Webinar',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.report,
        color: Colors.grey.shade400,
      ),
      activeItem: Icon(
        Icons.report,
        color: PRIMARY_COLOR,
      ),
      itemLabel: 'Report',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.chat_bubble,
        color: Colors.grey.shade400,
      ),
      activeItem: Icon(
        Icons.chat_bubble,
        color: PRIMARY_COLOR,
      ),
      itemLabel: 'Save Me',
    ),
    BottomBarItem(
      inActiveItem: Icon(
        Icons.person,
        color: Colors.grey.shade400,
      ),
      activeItem: Icon(
        Icons.person,
        color: PRIMARY_COLOR,
      ),
      itemLabel: 'Profile',
    ),
  ];
}
