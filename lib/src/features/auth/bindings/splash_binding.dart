import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/auth/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
   //Get.lazyPut<SplashController>(() => SplashController());
   Get.put(SplashController());
  }
}
