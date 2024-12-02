import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class SpecieProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _species;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get species => _species;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all species, avoiding duplicate fetches
  Future<void> fetchSpecies() async {
    if (_species != null) return; // Already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _species = await _service.fetchSpecies();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a specific species by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchSpecieById(String specieId) async {
    // Check if the species is already cached
    final cachedSpecie = _species?.firstWhere(
      (specie) => specie['_id'] == specieId,
      orElse: () => null, // Return null if not found
    );

    if (cachedSpecie != null) {
      return cachedSpecie;
    }

    try {
      // Fetch from service if not cached
      final specie = await _service.fetchSpeciesById(specieId);
      // Cache the fetched specie
      _species = [...?_species, specie];
      return specie;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error to allow error handling at a higher level
    }
  }
}
