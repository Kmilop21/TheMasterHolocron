import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CreatureProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _creatures; // Cached list of creatures
  bool _isLoading = false; // Loading state
  String? _error; // Error message if an API call fails

  List<dynamic>? get creatures => _creatures;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch data, using cached data if available
  Future<void> fetchCreatures() async {
    if (_creatures != null) {
      // Return early if creatures are already cached
      return;
    }

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
}
