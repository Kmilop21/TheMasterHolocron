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

  Future<void> fetchCreatures() async {
    if (_creatures != null) return; // Don't fetch again if already fetched

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

  // Fetch creature by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchCreatureById(String creatureId) async {
    // Check if the creature is already cached
    final cachedCreature = _creatures?.firstWhere(
      (creature) => creature['_id'] == creatureId,
      orElse: () => null, // Return null if not found
    );

    if (cachedCreature != null) {
      return cachedCreature;
    }

    // If not found, fetch from service
    _isLoading = true;
    notifyListeners();

    try {
      final creature = await _service.fetchCreatureById(creatureId);
      // Cache the creature
      _creatures?.add(creature); // Add to the list or cache as necessary
      return creature;
    } catch (e) {
      _error = e.toString();
      throw e; // Rethrow the error after caching
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
