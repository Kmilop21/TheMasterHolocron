import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/characters_provider.dart';

class CharacterDetailPage extends StatelessWidget {
  final String characterId;

  const CharacterDetailPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    // Use the CharacterProvider from the context
    final provider = Provider.of<CharacterProvider>(context, listen: false);

    // Check if the character data is already in the provider
    final character = provider.characters?.firstWhere(
      (character) => character['_id'] == characterId,
      orElse: () => null, // Return null if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
      ),
      body: character != null
          ? Padding(
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
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: provider.fetchCharacterById(characterId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
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
                } else {
                  return const Center(child: Text("Character not found"));
                }
              },
            ),
    );
  }
}
