import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';

class MoodRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertMood(MoodEntry entry) async {
    final db = await _databaseHelper.database;

    return await db.insert("mood_entries", entry.toMap());
  }

  Future<List<MoodEntry>> getAllMoods() async {
    final db = await _databaseHelper.database;

    final result = await db.query("mood_entries", orderBy: "createdAt DESC");

    return result.map((e) => MoodEntry.fromMap(e)).toList();
  }

  Future<void> deleteMood(int id) async {
    final db = await _databaseHelper.database;

    await db.delete("mood_entries", where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateMood(MoodEntry entry) async {
  final db = await _databaseHelper.database;

  await db.update(
    "mood_entries",
    entry.toMap(),
    where: "id = ?",
    whereArgs: [entry.id],
  );
}

  Future<void> toggleFavorite(int id, bool isFavorite) async {
    final db = await _databaseHelper.database;

    await db.update(
      "mood_entries",
      {"isFavorite": isFavorite ? 1 : 0},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<MoodEntry>> getFavoriteMoods() async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      "mood_entries",
      where: "isFavorite = ?",
      whereArgs: [1],
      orderBy: "createdAt DESC",
    );

    return result.map((e) => MoodEntry.fromMap(e)).toList();
  }
}
