import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesDatabase {
  static final FavoritesDatabase _instance = FavoritesDatabase._internal();
  Database? _db;

  FavoritesDatabase._internal();

  factory FavoritesDatabase() => _instance;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDB('favorites.db');
    return _db!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY
          )
        ''');
      },
    );
  }

  Future<void> addFavorite(String id) async {
    final db = await database;
    await db.insert('favorites', {'id': id},
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result =
        await db.query('favorites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
