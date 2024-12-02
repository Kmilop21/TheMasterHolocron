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

  Future<void> fetchSpecies() async {
    if (_species != null) return; // Don't fetch again if already fetched

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

  // Fetch specie by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchSpecieById(String specieId) async {
    // Check if the specie is already cached
    final cachedSpecie = _species?.firstWhere(
      (specie) => specie['_id'] == specieId,
      orElse: () => null, // Return null if not found
    );

    if (cachedSpecie != null) {
      return cachedSpecie;
    }

    // If not found, fetch from service
    _isLoading = true;
    notifyListeners();

    try {
      final specie = await _service.fetchSpeciesById(specieId);
      // Cache the specie
      _species?.add(specie); // Add to the list or cache as necessary
      return specie;
    } catch (e) {
      _error = e.toString();
      throw e; // Rethrow the error after caching
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
