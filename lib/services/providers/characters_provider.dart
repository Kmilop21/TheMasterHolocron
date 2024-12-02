import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CharacterProvider with ChangeNotifier {
  final StarWarsService _service = StarWarsService();
  List<dynamic>? _characters;
  bool _isLoading = false;
  String? _error;

  List<dynamic>? get characters => _characters;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCharacters() async {
    if (_characters != null) return; // Don't fetch again if already fetched

    _isLoading = true;
    notifyListeners();

    try {
      _characters = await _service.fetchCharacters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
