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

  // Fetch organization by ID, store in the provider and return
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

    // If not found, fetch from service
    _isLoading = true;
    notifyListeners();

    try {
      final organization = await _service.fetchOrganizationById(organizationId);
      // Cache the organization
      _organizations
          ?.add(organization); // Add to the list or cache as necessary
      return organization;
    } catch (e) {
      _error = e.toString();
      throw e; // Rethrow the error after caching
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
