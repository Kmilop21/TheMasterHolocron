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

  // Fetch all locations, avoiding duplicate fetches
  Future<void> fetchLocations() async {
    if (_locations != null) return; // Already fetched

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

  // Fetch a specific location by ID, avoiding unnecessary `notifyListeners` calls
  Future<Map<String, dynamic>> fetchLocationById(String locationId) async {
    // Check if the location is already cached
    final cachedLocation = _locations?.firstWhere(
      (location) => location['_id'] == locationId,
      orElse: () => null, // Return null if not found
    );

    if (cachedLocation != null) {
      return cachedLocation;
    }

    try {
      // Fetch from service if not cached
      final location = await _service.fetchLocationsById(locationId);
      // Cache the fetched location
      _locations = [...?_locations, location];
      return location;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error to allow error handling at a higher level
    }
  }
}
