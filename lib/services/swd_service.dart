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
    final url = '$baseUrl/characters/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
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

  Future<Map<String, dynamic>> fetchCreatureById(String id) async {
    final url = '$baseUrl/creatures/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
    } else {
      throw Exception('Failed to load creature');
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

  Future<Map<String, dynamic>> fetchDroidById(String id) async {
    final url = '$baseUrl/droids/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
    } else {
      throw Exception('Failed to load droid');
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

  Future<Map<String, dynamic>> fetchLocationsById(String id) async {
    final url = '$baseUrl/locations/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
    } else {
      throw Exception('Failed to load location');
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

  Future<Map<String, dynamic>> fetchOrganizationById(String id) async {
    final url = '$baseUrl/organizations/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
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

  Future<Map<String, dynamic>> fetchSpeciesById(String id) async {
    final url = '$baseUrl/species/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
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

  Future<Map<String, dynamic>> fetchVehicleById(String id) async {
    final url = '$baseUrl/vehicles/$id';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        throw Exception('Failed to parse response');
      }
    } else {
      throw Exception('Failed to load vehicle');
    }
  }
}
