import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class SpeciesProvider with ChangeNotifier {
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
}
