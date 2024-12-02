import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class VehicleProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _vehicles;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get vehicles => _vehicles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch all vehicles, avoiding duplicate fetches
  Future<void> fetchVehicles() async {
    if (_vehicles != null) return; // Already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _vehicles = await _service.fetchVehicles();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch a specific vehicle by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchVehicleById(String vehicleId) async {
    // Check if the vehicle is already cached
    final cachedVehicle = _vehicles?.firstWhere(
      (vehicle) => vehicle['_id'] == vehicleId,
      orElse: () => null, // Return null if not found
    );

    if (cachedVehicle != null) {
      return cachedVehicle;
    }

    try {
      // Fetch from service if not cached
      final vehicle = await _service.fetchVehicleById(vehicleId);
      // Cache the fetched vehicle
      _vehicles = [...?_vehicles, vehicle];
      return vehicle;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error to allow error handling at a higher level
    }
  }
}
