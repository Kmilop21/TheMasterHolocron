import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class LocationsProvider with ChangeNotifier {
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
}
