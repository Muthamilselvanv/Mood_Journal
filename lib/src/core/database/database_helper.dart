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

    return await openDatabase(
      path,
      version: 3, // 4
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users Table
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      username TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL,
      createdAt TEXT NOT NULL
    )
  ''');

    // Mood Entries Table
    await db.execute('''
    CREATE TABLE mood_entries(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      mood TEXT NOT NULL,
      weather TEXT NOT NULL,
      activities TEXT NOT NULL,
      intensity INTEGER NOT NULL,
      title TEXT NOT NULL,
      notes TEXT NOT NULL,
      createdAt TEXT NOT NULL,
      isFavorite INTEGER DEFAULT 0,
      imagePath TEXT,
      FOREIGN KEY(userId) REFERENCES users(id)
    )
  ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("ALTER TABLE mood_entries ADD COLUMN imagePath TEXT");
    }

    if (oldVersion < 3) {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
    }
  }
}
