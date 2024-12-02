import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class LocationProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _locations;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get locations => _locations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchLocations() async {
    if (_locations != null) return; // Don't fetch again if already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _locations = await _service.fetchLocations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch location by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchLocationById(String locationId) async {
    // Check if the location is already cached
    final cachedLocation = _locations?.firstWhere(
      (location) => location['_id'] == locationId,
      orElse: () => null, // Return null if not found
    );

    if (cachedLocation != null) {
      return cachedLocation;
    }

    // If not found, fetch from service
    _isLoading = true;
    notifyListeners();

    try {
      final location = await _service.fetchLocationsById(locationId);
      // Cache the location
      _locations?.add(location); // Add to the list or cache as necessary
      return location;
    } catch (e) {
      _error = e.toString();
      throw e; // Rethrow the error after caching
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
