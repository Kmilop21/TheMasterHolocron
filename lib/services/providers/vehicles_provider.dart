import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class VehiclesProvider with ChangeNotifier {
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
}
