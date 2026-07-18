import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Owns SQLite creation and schema migrations. Feature data sources own queries.
class AppDatabase {
  static const _databaseName = 'app.db';
  static const _databaseVersion = 1;
  Database? _instance;

  Future<Database> get database async {
    final existing = _instance;
    if (existing != null) return existing;
    final path = join(await getDatabasesPath(), _databaseName);
    final database = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    _instance = database;
    return database;
  }

  Future<void> _onCreate(Database db, int version) => db.execute('''
    CREATE TABLE mood_entries (
      id TEXT PRIMARY KEY,
      mood TEXT NOT NULL,
      note TEXT NOT NULL,
      created_at INTEGER NOT NULL
    )
  ''');

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add explicit, ordered migrations here as the schema evolves.
  }

  Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }
}
