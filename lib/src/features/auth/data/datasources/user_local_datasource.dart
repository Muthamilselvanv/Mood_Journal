import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  /// Register User
  Future<int> register(UserModel user) async {
    final Database db = await _databaseHelper.database;

    return await db.insert(
      "users",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  /// Login
  Future<UserModel?> login({
    required String username,
    required String password,
  }) async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      "users",
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return UserModel.fromMap(result.first);
  }

  /// Check username already exists
  Future<bool> usernameExists(String username) async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      "users",
      columns: ["id"],
      where: "username = ?",
      whereArgs: [username],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  /// Get user by ID
  Future<UserModel?> getUser(int id) async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      "users",
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return UserModel.fromMap(result.first);
  }

  /// Update profile
  Future<int> updateUser(UserModel user) async {
    final Database db = await _databaseHelper.database;

    return await db.update(
      "users",
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

  /// Delete account
  Future<int> deleteUser(int id) async {
    final Database db = await _databaseHelper.database;

    return await db.delete("users", where: "id = ?", whereArgs: [id]);
  }
}
