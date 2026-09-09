import 'package:get_storage/get_storage.dart';
import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/home/data/datasources/mood_firebase_datasource.dart';
import 'package:mood_journal_app/src/features/home/presentation/models/mood_entry_model.dart';
import 'package:sqflite/sqflite.dart';

class CloudWriteCompletedException implements Exception {
  const CloudWriteCompletedException(this.operation, this.cause);

  final String operation;
  final Object cause;

  @override
  String toString() => 'Cloud $operation completed, but local sync failed: $cause';
}

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

  Future<void> addMoodCompletely(MoodEntry entry) async {
    final firebaseId = await addMoodEntry(entry);

    try {
      await insertMood(entry.copyWith(firebaseId: firebaseId));
    } catch (error) {
      await _recoverAfterCloudWrite('save', error);
    }
  }

  Future<void> updateMoodCompletely(MoodEntry entry) async {
    await updateMoodEntry(entry);

    try {
      await updateMood(entry);
    } catch (error) {
      await _recoverAfterCloudWrite('update', error);
    }
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
        final firebaseIds = firebaseEntries
            .map((entry) => entry.firebaseId)
            .whereType<String>()
            .toList();

        if (firebaseIds.isEmpty) {
          await transaction.delete(
            'mood_entries',
            where: 'userId = ? AND firebaseId IS NOT NULL',
            whereArgs: [localUserId],
          );
        } else {
          final placeholders = List.filled(firebaseIds.length, '?').join(',');
          await transaction.delete(
            'mood_entries',
            where:
                'userId = ? AND firebaseId IS NOT NULL '
                'AND firebaseId NOT IN ($placeholders)',
            whereArgs: [localUserId, ...firebaseIds],
          );
        }

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

    } catch (_) {
      rethrow;
    }
  }

  Future<void> toggleFavoriteEntry(MoodEntry entry, bool isFavorite) async {
    var cloudUpdated = false;

    if (entry.firebaseId != null) {
      await _firebaseDataSource.toggleFavorite(entry.firebaseId!, isFavorite);
      cloudUpdated = true;
    }

    if (entry.id == null) return;

    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    try {
      final updatedRows = await db.update(
        'mood_entries',
        {'isFavorite': isFavorite ? 1 : 0},
        where: 'id = ? AND userId = ?',
        whereArgs: [entry.id, userId],
      );
      if (updatedRows != 1) {
        throw StateError('The local favorite row was not found.');
      }
    } catch (error) {
      if (!cloudUpdated) rethrow;
      await _recoverAfterCloudWrite('favorite update', error);
    }
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

    final deletedRows = await db.delete(
      'mood_entries',
      where: 'id = ? AND userId = ?',
      whereArgs: [id, userId],
    );
    if (deletedRows != 1) {
      throw StateError('The local mood row was not found.');
    }
  }

  Future<void> deleteMoodCompletely(MoodEntry entry) async {
    var cloudDeleted = false;

    if (entry.firebaseId != null) {
      await deleteMoodEntry(entry.firebaseId!);
      cloudDeleted = true;
    }

    if (entry.id != null) {
      try {
        await deleteMood(entry.id!);
      } catch (error) {
        if (!cloudDeleted) rethrow;
        await _recoverAfterCloudWrite('delete', error);
      }
    }
  }

  Future<void> _recoverAfterCloudWrite(String operation, Object cause) async {
    final box = GetStorage();
    final firebaseUid = box.read<String>('firebaseUid');
    final localUserId = box.read<int>('userId');

    if (firebaseUid == null || localUserId == null) {
      throw CloudWriteCompletedException(operation, cause);
    }

    try {
      await syncMoodEntriesFromFirebase(
        firebaseUid: firebaseUid,
        localUserId: localUserId,
      );
    } catch (_) {
      throw CloudWriteCompletedException(operation, cause);
    }
  }

  Future<void> updateMood(MoodEntry entry) async {
    if (entry.id == null) {
      throw ArgumentError('Local mood ID is required to update an entry.');
    }

    final db = await _databaseHelper.database;
    final userId = GetStorage().read<int>('userId');

    final updatedRows = await db.update(
      'mood_entries',
      entry.toMap(includeId: false),
      where: 'id = ? AND userId = ?',
      whereArgs: [entry.id, userId],
    );
    if (updatedRows != 1) {
      throw StateError('The local mood row was not found.');
    }
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
