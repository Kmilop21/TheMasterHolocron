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

  Future<Map<String, dynamic>> searchCharacterByName(String name) async {
  final formattedName = Uri.encodeComponent(name); // Codificar el nombre para la URL
  final url = '$baseUrl/characters/name/$formattedName';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data.isNotEmpty) {
      return data[0]; // La API devuelve una lista, tomamos el primer elemento.
    } else {
      throw Exception('No character found with the name "$name".');
    }
  } else {
    throw Exception('Failed to fetch character. HTTP status: ${response.statusCode}');
  }
}
/*
Future<Map<String, dynamic>> searchCharacterByName(String name) async {
  final response = await http.get(Uri.parse('$baseUrl/characters?name=$name'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data'];
    if (data.isNotEmpty) {
      // Filtrar resultados por coincidencia exacta
      final character = data.firstWhere(
        (char) => char['name'].toString().toLowerCase() == name.toLowerCase(),
        orElse: () => null,
      );

      if (character != null) {
        return character;
      } else {
        throw Exception('No character found with the exact name "$name".');
      }
    } else {
      throw Exception('No character found with the name "$name".');
    }
  } else {
    throw Exception('Failed to search character. HTTP status: ${response.statusCode}');
  }
}
*/
  /*
  Future<Map<String, dynamic>> searchCharacterByName(String name) async {
  final response = await http.get(Uri.parse('$baseUrl/characters?name=$name'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['data'];
    if (data.isNotEmpty) {
      return data[0]; // Retorna el primer resultado.
    } else {
      throw Exception('No character found');
    }
  } else {
    throw Exception('Failed to search character');
  }
}
*/
  /*
  Future<List<dynamic>> searchCharactersByName(String name) async {
  final response = await http.get(Uri.parse('$baseUrl/characters?name=$name'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['data'];
  } else {
    throw Exception('Failed to search characters');
  }
}
*/

  Future<Map<String, dynamic>> fetchCharacterById(String id) async {
    print("Fetching character with ID: $id");
    final url = '$baseUrl/characters/$id';
    print("Request URL: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        print("Decoded Response: $decodedResponse");
        return decodedResponse; // Directly return the response as a map
      } catch (e) {
        print("Error decoding response: $e");
        throw Exception('Failed to parse response');
      }
    } else {
      print(
          "Error: Failed to fetch character. Status code: ${response.statusCode}");
      print("Response body: ${response.body}");
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
