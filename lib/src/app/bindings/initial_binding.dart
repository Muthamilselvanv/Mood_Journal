import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/database/app_database.dart';

// Bindings is GetX’s dependency-registration class.
// Get.put creates and registers one AppDatabase.
// permanent: true means GetX keeps it during the whole app session.

// result: anywhere in the app, you can retrieve that same database manager with Get.find<AppDatabase>().

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppDatabase>(AppDatabase(), permanent: true);
  }
}
