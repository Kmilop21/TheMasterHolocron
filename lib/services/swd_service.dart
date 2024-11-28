import 'dart:convert';
import 'package:http/http.dart' as http;

class StarWarsService {
  final String baseUrl = "https://starwars-databank-server.vercel.app/api/v1/";

  Future<List<dynamic>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/characters'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Map<String, dynamic>> fetchCharacterById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/characters/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load character');
    }
  }

  Future<List<dynamic>> fetchCreatures() async {
    final response = await http.get(Uri.parse('$baseUrl/creatures'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load creatures');
    }
  }

  Future<List<dynamic>> fetchDroids() async {
    final response = await http.get(Uri.parse('$baseUrl/droids'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load droids');
    }
  }

  Future<List<dynamic>> fetchLocations() async {
    final response = await http.get(Uri.parse('$baseUrl/locations'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load locations');
    }
  }

  Future<List<dynamic>> fetchOrganizations() async {
    final response = await http.get(Uri.parse('$baseUrl/organizations'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load organizations');
    }
  }

  Future<List<dynamic>> fetchSpecies() async {
    final response = await http.get(Uri.parse('$baseUrl/species'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load species');
    }
  }

  Future<List<dynamic>> fetchVehicles() async {
    final response = await http.get(Uri.parse('$baseUrl/vehicles'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load vehicles');
    }
  }
}
