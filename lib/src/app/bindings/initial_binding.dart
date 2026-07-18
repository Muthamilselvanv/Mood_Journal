import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/database/app_database.dart';

/// Registers dependencies whose lifetime is the complete application session.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppDatabase>(AppDatabase(), permanent: true);
  }
}
