import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    final dbPath = join(path, 'discipline_os.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        priority TEXT DEFAULT 'medium',
        status TEXT DEFAULT 'pending',
        category TEXT,
        deadline INTEGER,
        estimated_minutes INTEGER,
        actual_minutes INTEGER,
        labels TEXT DEFAULT '[]',
        proof_required INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER,
        is_dirty INTEGER DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT,
        frequency TEXT DEFAULT 'daily',
        target INTEGER DEFAULT 1,
        unit TEXT DEFAULT 'times',
        current_streak INTEGER DEFAULT 0,
        longest_streak INTEGER DEFAULT 0,
        is_active INTEGER DEFAULT 1,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER,
        is_dirty INTEGER DEFAULT 1
      )
    ''');

    await db.execute('''
      CREATE TABLE goals (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        category TEXT DEFAULT 'personal',
        status TEXT DEFAULT 'not_started',
        target_date INTEGER,
        progress INTEGER DEFAULT 0,
        milestones TEXT DEFAULT '[]',
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        synced_at INTEGER,
        is_dirty INTEGER DEFAULT 1
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<List<Map<String, dynamic>>> getUnsyncedTasks() async {
    final db = await database;
    return await db.query('tasks', where: 'is_dirty = 1');
  }

  Future<List<Map<String, dynamic>>> getUnsyncedHabits() async {
    final db = await database;
    return await db.query('habits', where: 'is_dirty = 1');
  }

  Future<List<Map<String, dynamic>>> getUnsyncedGoals() async {
    final db = await database;
    return await db.query('goals', where: 'is_dirty = 1');
  }

  Future<void> markTaskSynced(String id) async {
    final db = await database;
    await db.update(
      'tasks',
      {'is_dirty': 0, 'synced_at': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markHabitSynced(String id) async {
    final db = await database;
    await db.update(
      'habits',
      {'is_dirty': 0, 'synced_at': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> markGoalSynced(String id) async {
    final db = await database;
    await db.update(
      'goals',
      {'is_dirty': 0, 'synced_at': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
