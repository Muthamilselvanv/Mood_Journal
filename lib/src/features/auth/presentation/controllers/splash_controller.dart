import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    print("SplashController onInit");

    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final box = GetStorage();

    final isLoggedIn = box.read("isLoggedIn") ?? false;
    final seenOnboarding = box.read("seenOnboarding") ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.home);
    } else if (seenOnboarding) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
