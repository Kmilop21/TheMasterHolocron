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
}
