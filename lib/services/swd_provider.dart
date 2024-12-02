import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:the_master_holocron/models/sw_entity.dart';

class SWDataProvider with ChangeNotifier {
  final Map<String, SWEntity> _entities = {}; // Stores all entities by their id
  final List<SWEntity> _favorites = []; // Stores favorite entities
  late Database _database;

  List<SWEntity> get favorites => List.unmodifiable(_favorites);

  // Getter for characters, filtering entities by category
  List<SWEntity> get characters => _entities.values
      .where((entity) =>
          entity.category == 'character') // Filter by 'character' category
      .toList();

  // Getter for a specific entity by id
  SWEntity? getEntityById(String id) => _entities[id];

  // Initialize the SQLite database
  Future<void> initializeDatabase() async {
    final path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'favorites.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id TEXT PRIMARY KEY, name TEXT, description TEXT, image TEXT, category TEXT)',
        );
      },
      version: 1,
    );

    await _loadFavorites(); // Load favorites from database
  }

  // Load favorite entities from the SQLite database
  Future<void> _loadFavorites() async {
    final List<Map<String, dynamic>> data = await _database.query('favorites');
    _favorites.clear();
    _favorites
        .addAll(data.map((json) => SWEntity.fromJson(json, json['category'])));
    notifyListeners();
  }

  // Add an entity to the favorites list (both in the database and in memory)
  Future<void> addFavorite(SWEntity entity) async {
    if (!_favorites.any((e) => e.id == entity.id)) {
      // Add to SQLite database
      await _database.insert('favorites', {
        'id': entity.id,
        'name': entity.name,
        'description': entity.description,
        'image': entity.image,
        'category': entity.category,
      });
      _favorites.add(entity);
      notifyListeners();
    }
  }

  // Remove an entity from the favorites list (both in the database and in memory)
  Future<void> removeFavorite(SWEntity entity) async {
    await _database
        .delete('favorites', where: 'id = ?', whereArgs: [entity.id]);
    _favorites.removeWhere((e) => e.id == entity.id);
    notifyListeners();
  }

  // Check if an entity is in the favorites list
  bool isFavorite(String id) => _favorites.any((e) => e.id == id);

  // Add a new entity (could be a character, creature, etc.) to the provider
  void addEntity(SWEntity entity) {
    _entities[entity.id] = entity;
    notifyListeners();
  }

  // Add multiple entities to the provider (for example, characters or creatures)
  void addEntities(List<Map<String, dynamic>> entities, String category) {
    for (var entity in entities) {
      final swEntity = SWEntity.fromJson(entity, category);
      _entities[swEntity.id] = swEntity;
    }
    notifyListeners();
  }
}
