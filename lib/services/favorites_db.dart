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
    CREATE TABLE favorites_character (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_creature (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_droid (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_location (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      image TEXT
    )
  ''');
        await db.execute('''
    CREATE TABLE favorites_organization (
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
    CREATE TABLE favorites_vehicle (
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
    final tableName = 'favorites_${entity.category}';
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
    final tableName = 'favorites_${category}';
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isFavorite(String id, String category) async {
    final db = await _getDatabase();
    final tableName = 'favorites_${category}';
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  Future<List<SWEntity>> fetchFavorites(String category) async {
    final db = await _getDatabase();
    final tableName = 'favorites_${category}';
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
