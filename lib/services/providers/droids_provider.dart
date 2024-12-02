import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class DroidProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _droids;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get droids => _droids;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all droids, avoiding duplicate fetches
  Future<void> fetchDroids() async {
    if (_droids != null) return; // Already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _droids = await _service.fetchDroids();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a specific droid by ID, avoiding unnecessary `notifyListeners` calls
  Future<Map<String, dynamic>> fetchDroidById(String droidId) async {
    // Check if the droid is already cached
    final cachedDroid = _droids?.firstWhere(
      (droid) => droid['_id'] == droidId,
      orElse: () => null, // Return null if not found
    );

    if (cachedDroid != null) {
      return cachedDroid;
    }

    try {
      // Fetch from service if not cached
      final droid = await _service.fetchDroidById(droidId);
      // Cache the fetched droid
      _droids = [...?_droids, droid];
      return droid;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error to allow error handling at a higher level
    }
  }
}
