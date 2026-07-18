import 'package:mood_journal_app/src/core/database/app_database.dart';
import 'package:mood_journal_app/src/features/mood/data/models/mood_entry_model.dart';

abstract interface class MoodLocalDataSource {
  Future<List<MoodEntryModel>> getEntries();
  Future<void> saveEntry(MoodEntryModel entry);
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  const MoodLocalDataSourceImpl(this._database);
  final AppDatabase _database;

  @override
  Future<List<MoodEntryModel>> getEntries() async {
    final db = await _database.database;
    final rows = await db.query('mood_entries', orderBy: 'created_at DESC');
    return rows.map(MoodEntryModel.fromMap).toList();
  }

  @override
  Future<void> saveEntry(MoodEntryModel entry) async {
    final db = await _database.database;
    await db.insert('mood_entries', entry.toMap());
  }
}
