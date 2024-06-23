import 'package:get/get.dart';
import 'package:save_me_new/app/modules/auth/auth_service.dart';
import 'package:save_me_new/app/routes/app_pages.dart';

class ProfilePageController extends GetxController {
  //TODO: Implement ProfilePageController

  final auth = AuthService();

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

  void increment() => count.value++;
  Future<void> handleLogout() async {
    auth.signOut();
    Get.offAllNamed(Routes.AUTH_GATE);
  }
}
