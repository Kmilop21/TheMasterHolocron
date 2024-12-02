import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_master_holocron/models/sw_entity.dart';

class StarWarsService {
  final String baseUrl = "https://starwars-databank-server.vercel.app/api/v1/";

  Future<List<SWEntity>> fetchEntities(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/$category'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['data'];
      return jsonData.map((json) => SWEntity.fromJson(json, category)).toList();
    } else {
      throw Exception('Failed to load $category');
    }
  }

  Future<List<dynamic>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/characters'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<Map<String, dynamic>> searchCharacterByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/characters/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No character found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch character. HTTP status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchCreatureByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/creatures/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No creature found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch creature. HTTP status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchDroidByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/droids/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No droid found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch droid. HTTP status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchLocationsByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/locations/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No location found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch location. HTTP status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchOrganizationsByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/organizations/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No organization found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch organization. HTTP status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchSpeciesByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/species/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No specie found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch specie. HTTP status: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> searchVehiclesByName(String name) async {
    final formattedName =
        Uri.encodeComponent(name); // Codificar el nombre para la URL
    final url = '$baseUrl/vehicles/name/$formattedName';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[
            0]; // La API devuelve una lista, tomamos el primer elemento.
      } else {
        throw Exception('No vehicle found with the name "$name".');
      }
    } else {
      throw Exception(
          'Failed to fetch vehicle. HTTP status: ${response.statusCode}');
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
