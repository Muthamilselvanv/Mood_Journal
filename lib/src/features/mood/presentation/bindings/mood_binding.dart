import 'package:get/get.dart';
import 'package:mood_journal_app/src/core/database/app_database.dart';
import 'package:mood_journal_app/src/features/mood/data/datasources/mood_local_data_source.dart';
import 'package:mood_journal_app/src/features/mood/data/repositories/mood_repository_impl.dart';
import 'package:mood_journal_app/src/features/mood/domain/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/mood/domain/usecases/add_mood_entry.dart';
import 'package:mood_journal_app/src/features/mood/domain/usecases/get_mood_entries.dart';
import 'package:mood_journal_app/src/features/mood/presentation/controllers/mood_controller.dart';

class MoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoodLocalDataSource>(() => MoodLocalDataSourceImpl(Get.find<AppDatabase>()));
    Get.lazyPut<MoodRepository>(() => MoodRepositoryImpl(Get.find<MoodLocalDataSource>()));
    Get.lazyPut(() => AddMoodEntry(Get.find<MoodRepository>()));
    Get.lazyPut(() => GetMoodEntries(Get.find<MoodRepository>()));
    Get.lazyPut(() => MoodController(addMoodEntry: Get.find(), getMoodEntries: Get.find()));
  }
}
