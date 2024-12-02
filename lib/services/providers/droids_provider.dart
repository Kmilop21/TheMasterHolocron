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

  Future<void> fetchDroids() async {
    if (_droids != null) return; // Don't fetch again if already fetched

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

  // Fetch droid by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchDroidById(String droidId) async {
    // Check if the droid is already cached
    final cachedDroid = _droids?.firstWhere(
      (droid) => droid['_id'] == droidId,
      orElse: () => null, // Return null if not found
    );

    if (cachedDroid != null) {
      return cachedDroid;
    }

    // If not found, fetch from service
    _isLoading = true;
    notifyListeners();

    try {
      final droid = await _service.fetchDroidById(droidId);
      // Cache the droid
      _droids?.add(droid); // Add to the list or cache as necessary
      return droid;
    } catch (e) {
      _error = e.toString();
      throw e; // Rethrow the error after caching
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
