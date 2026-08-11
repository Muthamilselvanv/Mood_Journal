import 'package:sqflite/sqflite.dart';

import 'package:mood_journal_app/src/core/database/database_helper.dart';
import 'package:mood_journal_app/src/features/auth/data/models/user_model.dart';

class ProfileLocalDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<UserModel?> getUser(int userId) async {
    final Database db = await _databaseHelper.database;

    final result = await db.query(
      "users",
      where: "id = ?",
      whereArgs: [userId],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return UserModel.fromMap(result.first);
  }

  Future<void> updateProfile(UserModel user) async {
    final Database db = await _databaseHelper.database;

    await db.update(
      "users",
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }
}
