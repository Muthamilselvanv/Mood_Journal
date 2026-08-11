import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/home/data/datasources/mood_firebase_datasource.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:sqflite/sqflite.dart';

class MoodRepository {
  MoodRepository(this._firebaseDataSource);

  final MoodFirebaseDataSource _firebaseDataSource;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<String> addMoodEntry(MoodEntry entry) {
    return _firebaseDataSource.addMoodEntry(entry);
  }

  Future<void> updateMoodEntry(MoodEntry entry) {
    return _firebaseDataSource.updateMoodEntry(entry);
  }

  Future<void> deleteMoodEntry(String firebaseId) {
    return _firebaseDataSource.deleteMoodEntry(firebaseId);
  }

  Future<List<MoodEntry>> getMoodEntriesFromFirebase(String firebaseUid) {
    return _firebaseDataSource.getMoodEntries(firebaseUid);
  }

  Future<void> syncMoodEntriesFromFirebase({
    required String firebaseUid,
    required int localUserId,
  }) async {
    try {
      final firebaseEntries = await _firebaseDataSource.getMoodEntries(
        firebaseUid,
      );
      final db = await _databaseHelper.database;

      await db.transaction((transaction) async {
        for (final firebaseEntry in firebaseEntries) {
          final localEntry = firebaseEntry.copyWith(userId: localUserId);

          final existing = await transaction.query(
            'mood_entries',
            columns: ['id'],
            where: 'firebaseId = ? AND userId = ?',
            whereArgs: [localEntry.firebaseId, localUserId],
            limit: 1,
          );

          if (existing.isEmpty) {
            await transaction.insert(
              'mood_entries',
              localEntry.toMap(includeId: false),
              conflictAlgorithm: ConflictAlgorithm.abort,
            );
          } else {
            await transaction.update(
              'mood_entries',
              localEntry.toMap(includeId: false),
              where: 'id = ? AND userId = ?',
              whereArgs: [existing.first['id'], localUserId],
            );
          }
        }
      });

      debugPrint('Firebase journals synced: ${firebaseEntries.length}');
    } catch (error, stackTrace) {
      debugPrint('JOURNAL SYNC ERROR: $error');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> toggleFavoriteEntry(MoodEntry entry, bool isFavorite) async {
    if (entry.firebaseId != null) {
      await _firebaseDataSource.toggleFavorite(entry.firebaseId!, isFavorite);
    }

    if (entry.id == null) return;

    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    await db.update(
      'mood_entries',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ? AND userId = ?',
      whereArgs: [entry.id, userId],
    );
  }

  Future<int> insertMood(MoodEntry entry) async {
    final db = await _databaseHelper.database;

    return db.insert(
      'mood_entries',
      entry.toMap(includeId: false),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<MoodEntry>> getAllMoods() async {
    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    if (userId == null) return <MoodEntry>[];

    final result = await db.query(
      'mood_entries',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );

    return result.map(MoodEntry.fromMap).toList();
  }

  Future<void> deleteMood(int id) async {
    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    await db.delete(
      'mood_entries',
      where: 'id = ? AND userId = ?',
      whereArgs: [id, userId],
    );
  }

  Future<void> deleteMoodCompletely(MoodEntry entry) async {
    if (entry.firebaseId != null) {
      await deleteMoodEntry(entry.firebaseId!);
    }

    if (entry.id != null) {
      await deleteMood(entry.id!);
    }
  }

  Future<void> updateMood(MoodEntry entry) async {
    if (entry.id == null) {
      throw ArgumentError('Local mood ID is required to update an entry.');
    }

    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    await db.update(
      'mood_entries',
      entry.toMap(includeId: false),
      where: 'id = ? AND userId = ?',
      whereArgs: [entry.id, userId],
    );
  }

  Future<List<MoodEntry>> getFavoriteMoods() async {
    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    if (userId == null) return <MoodEntry>[];

    final result = await db.query(
      'mood_entries',
      where: 'userId = ? AND isFavorite = ?',
      whereArgs: [userId, 1],
      orderBy: 'createdAt DESC',
    );

    return result.map(MoodEntry.fromMap).toList();
  }
}
