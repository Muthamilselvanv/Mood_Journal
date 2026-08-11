import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> register(UserModel user) async {
    final db = await _databaseHelper.database;

    return db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  /// Creates the local user after a fresh install, or updates its profile while
  /// retaining its existing SQLite primary key.
  Future<int> insertUser({
    required String firebaseUid,
    required String name,
    required String email,
  }) async {
    final db = await _databaseHelper.database;

    final existing = await getUserByFirebaseUid(firebaseUid);

    if (existing != null) {
      await db.update(
        'users',
        {'name': name, 'email': email},
        where: 'id = ?',
        whereArgs: [existing.id],
      );
      return existing.id!;
    }

    return db.insert('users', {
      'firebaseUid': firebaseUid,
      'name': name,
      'email': email,
      'profileImage': null,
      'bio': null,
      'createdAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  Future<bool> emailExists(String email) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'users',
      columns: ['id'],
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<UserModel?> getUserByFirebaseUid(String firebaseUid) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'users',
      where: 'firebaseUid = ?',
      whereArgs: [firebaseUid],
      limit: 1,
    );

    return result.isEmpty ? null : UserModel.fromMap(result.first);
  }

  Future<UserModel?> getUser(int id) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    return result.isEmpty ? null : UserModel.fromMap(result.first);
  }

  Future<int> updateUser(UserModel user) async {
    final db = await _databaseHelper.database;

    return db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await _databaseHelper.database;
    return db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
