import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/modules/home_page/views/home_page_view.dart';
import 'package:save_me_new/app/modules/profile_page/views/profile_page_view.dart';
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
      title: 'Rent Room',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      darkTheme: ThemeData.dark(),
      home: Wrapper(),
    );
  }
}

class Wrapper extends GetWidget<HomeLayoutController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<HomeLayoutController>(
      () => HomeLayoutController(),
    );
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarItems(),
      controller: Get.find<HomeLayoutController>().controller,
      confineInSafeArea: true,
      // backgroundColor: Colors.black,
      backgroundColor: Color(0xffEFEFF3),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(30.0),
        colorBehindNavBar: Colors.white,
      ),

      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 300)),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

List<Widget> _buildScreens() {
  final AuthService _authService = AuthService();
  // return for admin
  if (_authService.getCurretUser()!.email == 'admin@gmail.com') {
    return [
      HomePageView(),
      WebinarPageView(),
      ReportPageView(),
      AdminPageView(),
      ProfilePageView(),
    ];
  }
  // return for user
  return [
    HomePageView(),
    WebinarPageView(),
    ReportPageView(),
    SavemePageView(),
    ProfilePageView(),
  ];
}

List<PersistentBottomNavBarItem> _navBarItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: PRIMARY_COLOR,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.slideshow),
      title: ("Webinar"),
      activeColorPrimary: PRIMARY_COLOR,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.report),
      title: ("Lapor"),
      activeColorPrimary: PRIMARY_COLOR,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.chat_bubble),
      title: ("Deep Talk"),
      activeColorPrimary: PRIMARY_COLOR,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.person),
      title: ("Profile"),
      activeColorPrimary: PRIMARY_COLOR,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}
