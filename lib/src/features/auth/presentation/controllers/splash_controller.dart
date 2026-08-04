import 'package:get/get.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAllNamed(AppRoutes.onboarding);
  }
}
