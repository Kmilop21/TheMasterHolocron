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

  Future<void> fetchVehicles() async {
    if (_vehicles != null) return; // Don't fetch again if already fetched

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

  // Fetch vehicle by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchVehicleById(String vehicleId) async {
    // Check if the vehicle is already cached
    final cachedVehicle = _vehicles?.firstWhere(
      (vehicle) => vehicle['_id'] == vehicleId,
      orElse: () => null, // Return null if not found
    );

    if (cachedVehicle != null) {
      return cachedVehicle;
    }

    // If not found, fetch from service
    _isLoading = true;
    notifyListeners();

    try {
      final vehicle = await _service.fetchVehicleById(vehicleId);
      // Cache the vehicle
      _vehicles?.add(vehicle); // Add to the list or cache as necessary
      return vehicle;
    } catch (e) {
      _error = e.toString();
      throw e; // Rethrow the error after caching
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
