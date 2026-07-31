import 'package:get/get.dart';
import 'package:mood_journal_app/src/features/home/data/repositories/mood_repository.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

class JournalController extends GetxController {
  final selectedFilter = "All".obs;

  final moodEntries = <MoodEntry>[].obs;

  final MoodRepository repository = Get.find();

  @override
  void onInit() {
    super.onInit();
    loadEntries();
  }

  Future<void> loadEntries() async {
    moodEntries.value = await repository.getAllMoods();
  }

  final filters = const ["All", "Happy", "Calm", "Neutral", "Sad", "Angry"];

  void changeFilter(String mood) {
    selectedFilter.value = mood;
  }
}
