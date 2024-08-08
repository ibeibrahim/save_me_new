import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_gate.dart';
import 'package:save_me_new/app/modules/deeptalk_page/views/admin_page_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home_layout/bindings/home_layout_binding.dart';
import '../modules/home_layout/views/home_layout_view.dart';
import '../modules/home_page/bindings/home_page_binding.dart';
import '../modules/home_page/views/home_page_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/report_page/bindings/report_page_binding.dart';
import '../modules/report_page/views/report_page_view.dart';
import '../modules/deeptalk_page/bindings/saveme_page_binding.dart';
import '../modules/deeptalk_page/views/saveme_page_view.dart';
import '../modules/splash_screen/bindings/splash_binding.dart';
import '../modules/splash_screen/views/splash_view.dart';
import '../modules/webinar_page/bindings/webinar_page_binding.dart';
import '../modules/webinar_page/views/webinar_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME_LAYOUT,
      page: () => HomeLayoutView(),
      binding: HomeLayoutBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_GATE,
      page: () => const AuthGate(),
    ),
    GetPage(
      name: _Paths.ADMIN_PAGE,
      page: () => AdminPageView(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_PAGE,
      page: () => const ReportPageView(),
      binding: ReportPageBinding(),
    ),
    GetPage(
      name: _Paths.SAVEME_PAGE,
      page: () => SavemePageView(),
      binding: SavemePageBinding(),
    ),
    GetPage(
      name: _Paths.WEBINAR_PAGE,
      page: () => WebinarPageView(),
      binding: WebinarPageBinding(),
    ),
  ];
}
