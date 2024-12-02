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

  Future<Map<String, dynamic>> fetchCharacterById(String characterId) async {
    // Check if the character is already cached
    final cachedCharacter = _characters?.firstWhere(
      (character) => character['_id'] == characterId,
      orElse: () => null,
    );

    if (cachedCharacter != null) {
      return cachedCharacter;
    }

    try {
      final character = await _service.fetchCharacterById(characterId);
      // Cache the character without notifying listeners immediately
      _characters = [...?_characters, character];
      return character;
    } catch (e) {
      _error = e.toString();
      rethrow; // Rethrow the error after caching
    }
  }
}
