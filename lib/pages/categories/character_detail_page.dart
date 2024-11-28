import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CharacterDetailPage extends StatelessWidget {
  final String characterId;

  const CharacterDetailPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchCharacterById(characterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final character = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(character['image']),
                  const SizedBox(height: 16),
                  Text(
                    character['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(character['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
