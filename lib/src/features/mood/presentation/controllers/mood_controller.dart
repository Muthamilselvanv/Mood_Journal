import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/mood/domain/entities/mood_entry.dart';
import 'package:mood_journal_app/src/features/mood/domain/usecases/add_mood_entry.dart';
import 'package:mood_journal_app/src/features/mood/domain/usecases/get_mood_entries.dart';

class MoodController extends GetxController {
  MoodController({required this.addMoodEntry, required this.getMoodEntries});
  final AddMoodEntry addMoodEntry;
  final GetMoodEntries getMoodEntries;

  final entries = <MoodEntry>[].obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  @override
  void onReady() {
    super.onReady();
    loadEntries();
  }

  Future<void> loadEntries() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      entries.assignAll(await getMoodEntries());
    } catch (_) {
      errorMessage.value = 'Could not load mood entries.';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createEntry({required String mood, required String note}) async {
    errorMessage.value = null;
    try {
      final entry = MoodEntry(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        mood: mood,
        note: note.trim(),
        createdAt: DateTime.now(),
      );
      await addMoodEntry(entry);
      await loadEntries();
    } catch (error) {
      errorMessage.value = error.toString();
    }
  }
}
