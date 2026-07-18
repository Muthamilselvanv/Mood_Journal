import 'package:mood_journal_app/src/features/mood/domain/entities/mood_entry.dart';
import 'package:mood_journal_app/src/features/mood/domain/repositories/mood_repository.dart';

class GetMoodEntries {
  const GetMoodEntries(this._repository);
  final MoodRepository _repository;
  Future<List<MoodEntry>> call() => _repository.getEntries();
}
