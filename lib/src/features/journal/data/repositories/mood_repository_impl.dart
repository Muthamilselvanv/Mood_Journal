import 'package:mood_journal_app/src/features/journal/data/datasources/mood_local_data_source.dart';
import 'package:mood_journal_app/src/features/journal/data/models/mood_entry_model.dart';
import 'package:mood_journal_app/src/features/journal/domain/entities/mood_entry.dart';
import 'package:mood_journal_app/src/features/journal/domain/repositories/mood_repository.dart';

class MoodRepositoryImpl implements MoodRepository {
  const MoodRepositoryImpl(this._localDataSource);
  final MoodLocalDataSource _localDataSource;

  @override
  Future<List<MoodEntry>> getEntries() async => (await _localDataSource.getEntries()).map((model) => model.toEntity()).toList();

  @override
  Future<void> saveEntry(MoodEntry entry) => _localDataSource.saveEntry(MoodEntryModel.fromEntity(entry));
}
