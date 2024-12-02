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

  // Fetch all organizations, avoiding duplicate fetches
  Future<void> fetchOrganizations() async {
    if (_organizations != null) return; // Already fetched

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

  // Fetch a specific organization by ID, store in the provider and return
  Future<Map<String, dynamic>> fetchOrganizationById(
      String organizationId) async {
    // Check if the organization is already cached
    final cachedOrganization = _organizations?.firstWhere(
      (organization) => organization['_id'] == organizationId,
      orElse: () => null, // Return null if not found
    );

    if (cachedOrganization != null) {
      return cachedOrganization;
    }

    try {
      // Fetch from service if not cached
      final organization = await _service.fetchOrganizationById(organizationId);
      // Cache the fetched organization
      _organizations = [...?_organizations, organization];
      return organization;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error to allow error handling at a higher level
    }
  }
}
