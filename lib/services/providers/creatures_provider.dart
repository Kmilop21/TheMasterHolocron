import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CreatureProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _creatures;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get creatures => _creatures;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all creatures, avoiding duplicate fetches
  Future<void> fetchCreatures() async {
    if (_creatures != null) return; // Already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _creatures = await _service.fetchCreatures();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a specific creature by ID, avoiding unnecessary `notifyListeners` calls
  Future<Map<String, dynamic>> fetchCreatureById(String creatureId) async {
    // Check if the creature is already cached
    final cachedCreature = _creatures?.firstWhere(
      (creature) => creature['_id'] == creatureId,
      orElse: () => null, // Return null if not found
    );

    if (cachedCreature != null) {
      return cachedCreature;
    }

    try {
      // Fetch from service if not cached
      final creature = await _service.fetchCreatureById(creatureId);
      // Cache the fetched creature
      _creatures = [...?_creatures, creature];
      return creature;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error to allow error handling at a higher level
    }
  }
}
