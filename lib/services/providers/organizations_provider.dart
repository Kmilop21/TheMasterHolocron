import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class OrganizationProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _organizations;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get organizations => _organizations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchOrganizations() async {
    if (_organizations != null) return; // Don't fetch again if already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _organizations = await _service.fetchOrganizations();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
