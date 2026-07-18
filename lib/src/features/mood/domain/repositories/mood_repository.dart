import 'package:mood_journal_app/src/features/mood/domain/entities/mood_entry.dart';

abstract interface class MoodRepository {
  Future<List<MoodEntry>> getEntries();
  Future<void> saveEntry(MoodEntry entry);
}
