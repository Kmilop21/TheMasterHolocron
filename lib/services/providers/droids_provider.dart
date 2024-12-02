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
}
