import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

class JournalController extends GetxController {
  final selectedFilter = "All".obs;

  final moodEntries = <MoodEntry>[].obs;

  final MoodRepository repository = Get.find();

  bool get hasFirstEntry => moodEntries.isNotEmpty;

  bool get isMoodMaster => moodEntries.length >= 10;

  @override
  void onInit() {
    super.onInit();
    loadEntries();
    loadMood();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  Future<void> loadMood() async {
    final repository = Get.find<MoodRepository>();

    final moods = await repository.getAllMoods();

    print("Total entries: ${moods.length}");
  }

  final searchController = TextEditingController();

  final searchText = "".obs;

  void onSearch(String value) {
    searchText.value = value.trim().toLowerCase();
  }

  int searchScore(MoodEntry entry, String keyword) {
    int score = 0;

    if (entry.title.toLowerCase().startsWith(keyword)) {
      score += 100;
    }

    if (entry.title.toLowerCase().contains(keyword)) {
      score += 50;
    }

    if (entry.notes.toLowerCase().contains(keyword)) {
      score += 30;
    }

    if (entry.mood.toLowerCase().contains(keyword)) {
      score += 20;
    }

    if (entry.weather.toLowerCase().contains(keyword)) {
      score += 10;
    }

    return score;
  }

  List<MoodEntry> get filteredEntries {
    List<MoodEntry> list = List.from(moodEntries);

    // Mood Filter
    if (selectedFilter.value != "All") {
      list = list.where((e) => e.mood == selectedFilter.value).toList();
    }

    final keyword = searchText.value.trim().toLowerCase();

    if (keyword.isNotEmpty) {
      list.sort((a, b) {
        final aScore = searchScore(a, keyword);
        final bScore = searchScore(b, keyword);

        return bScore.compareTo(aScore);
      });

      list = list.where((e) => searchScore(e, keyword) > 0).toList();
    }

    return list;
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

  // the longest streak calculation
  int get longestStreak {
    if (moodEntries.isEmpty) return 0;

    // Unique dates only
    final dates =
        moodEntries
            .map(
              (e) => DateTime(
                e.createdAt.year,
                e.createdAt.month,
                e.createdAt.day,
              ),
            )
            .toSet()
            .toList()
          ..sort();

    int longest = 1;
    int current = 1;

    for (int i = 1; i < dates.length; i++) {
      final difference = dates[i].difference(dates[i - 1]).inDays;

      if (difference == 1) {
        current++;
        if (current > longest) {
          longest = current;
        }
      } else {
        current = 1;
      }
    }

    return longest;
  }

  //trend stats calculation
  String get mostCommonMood {
    if (moodEntries.isEmpty) return "🔒";

    final Map<String, int> counts = {};

    for (final mood in moodEntries) {
      counts[mood.mood] = (counts[mood.mood] ?? 0) + 1;
    }

    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }

  Future<void> toggleFavorite(MoodEntry entry) async {
    await repository.toggleFavorite(entry.id!, !entry.isFavorite);

    await loadEntries();
  }

  Future<void> deleteEntry(MoodEntry entry) async {
    if (entry.id == null) return;

    print("Deleting ${entry.id}");

    await repository.deleteMood(entry.id!);

    await loadEntries();

    print("Remaining: ${moodEntries.length}");
  }
}
