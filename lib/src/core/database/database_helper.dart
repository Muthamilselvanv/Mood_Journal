// Creating the database
// Creating tables
// Opening the database
// Returning the database instance

// Notice the responsibilities:

// database → returns an existing database or creates it
// _initDatabase() → opens the SQLite file
// _onCreate() → creates your tables

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'mood_journal.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mood_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mood TEXT NOT NULL,
        weather TEXT NOT NULL,
        activities TEXT NOT NULL,
        intensity INTEGER NOT NULL,
        title TEXT NOT NULL,
        notes TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        isFavorite INTEGER DEFAULT 0
      )
    ''');
  }
}
