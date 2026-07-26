import 'package:mood_journal_app/src/core/errors/app_exception.dart';
import 'package:mood_journal_app/src/features/journal/domain/entities/mood_entry.dart';
import 'package:mood_journal_app/src/features/journal/domain/repositories/mood_repository.dart';

class AddMoodEntry {
  const AddMoodEntry(this._repository);
  final MoodRepository _repository;

  Future<void> call(MoodEntry entry) {
    if (entry.mood.trim().isEmpty) {
      throw const AppException('Please select a mood.');
    }
    return _repository.saveEntry(entry);
  }
}
