import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

class JournalController extends GetxController {
  final selectedFilter = "All".obs;

  final moodEntries = <MoodEntry>[].obs;

  final MoodRepository repository = Get.find();

  Future<void> loadMood() async {
    final repository = Get.find<MoodRepository>();

    final moods = await repository.getAllMoods();

    print("Total entries: ${moods.length}");
  }

  @override
  void onInit() {
    super.onInit();
    loadEntries();
    loadMood();
  }

  Future<void> loadEntries() async {
    moodEntries.value = await repository.getAllMoods();
  }

  final filters = const ["All", "Happy", "Calm", "Neutral", "Sad", "Angry"];

  void changeFilter(String mood) {
    selectedFilter.value = mood;
  }

  // average mood calculation
  double get averageMood {
    if (moodEntries.isEmpty) return 0.0;

    final totalMoodValue = moodEntries.fold<int>(
      0,
      (sum, item) => sum + item.intensity,
    );

    return totalMoodValue / moodEntries.length;
  }

  // day streak calculation
  int get activeDays {
    return moodEntries
        .map(
          (e) => DateTime(e.createdAt.year, e.createdAt.month, e.createdAt.day),
        )
        .toSet()
        .length;
  }
  
}
