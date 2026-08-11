import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'mood_journal.db'),
      version: 4,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firebaseUid TEXT NOT NULL UNIQUE,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        profileImage TEXT,
        bio TEXT,
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE mood_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER NOT NULL,
        firebaseId TEXT,
        mood TEXT NOT NULL,
        weather TEXT NOT NULL,
        activities TEXT NOT NULL,
        intensity INTEGER NOT NULL,
        title TEXT NOT NULL,
        notes TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        isFavorite INTEGER DEFAULT 0,
        imageUrl TEXT,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE UNIQUE INDEX mood_entries_user_firebase_unique
      ON mood_entries(userId, firebaseId)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE mood_entries ADD COLUMN imageUrl TEXT');
    }

    if (oldVersion < 3) {
      await db.execute('ALTER TABLE mood_entries ADD COLUMN firebaseId TEXT');
    }

    if (oldVersion < 4) {
      // Retain the newest row if prior versions already created duplicates.
      await db.execute('''
        DELETE FROM mood_entries
        WHERE firebaseId IS NOT NULL
          AND id NOT IN (
            SELECT MAX(id)
            FROM mood_entries
            WHERE firebaseId IS NOT NULL
            GROUP BY userId, firebaseId
          )
      ''');

      await db.execute('''
        CREATE UNIQUE INDEX IF NOT EXISTS mood_entries_user_firebase_unique
        ON mood_entries(userId, firebaseId)
      ''');
    }
  }
}
