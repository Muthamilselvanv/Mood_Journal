import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/journal/presentation/controllers/journal_controller.dart';
import 'package:mood_journal_app/src/features/main/presentation/controller/main_controller.dart';
import 'package:mood_journal_app/src/features/home/presentation/controllers/home_controller.dart';
import 'package:mood_journal_app/src/features/trends/presentation/controllers/trends_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut<MoodRepository>(() => MoodRepository(), fenix: true);
    Get.lazyPut(() => JournalController());
    Get.lazyPut(() => TrendsController());
  }
}
