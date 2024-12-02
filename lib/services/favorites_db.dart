import 'package:sqflite/sqflite.dart';
import 'package:the_master_holocron/models/sw_entity.dart';

class FavoritesDatabase {
  static final FavoritesDatabase _instance = FavoritesDatabase._internal();

  factory FavoritesDatabase() => _instance;

  FavoritesDatabase._internal();

  Database? _db;

  Future<Database> _getDatabase() async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      'favorites.db',
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
    CREATE TABLE favorites_characters (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_creatures (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_droids (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_locations (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_organizations (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_species (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_vehicles (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
      },
    );
    return _db!;
  }

  Future<void> addFavorite(SWEntity entity) async {
    final db = await _getDatabase();
    final tableName = 'favorites_${entity.category}s';
    await db.insert(
      tableName,
      {
        'id': entity.id,
        'name': entity.name,
        'description': entity.description,
        'image': entity.image,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id, String category) async {
    final db = await _getDatabase();
    final tableName = 'favorites_${category}s';
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String id, String category) async {
    final db = await _getDatabase();
    final tableName = 'favorites_${category}s';
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<List<SWEntity>> fetchFavorites(String category) async {
    final db = await _getDatabase();
    final tableName = 'favorites_${category}s';
    final result = await db.query(tableName);

    return result.map((row) {
      return SWEntity(
        id: row['id'] as String,
        name: row['name'] as String,
        description: row['description'] as String,
        image: row['image'] as String,
        category: category,
      );
    }).toList();
  }
}
