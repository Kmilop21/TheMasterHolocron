import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';
import 'package:share_plus/share_plus.dart';

class CharacterDetailPage extends StatelessWidget {
  final String characterId;

  const CharacterDetailPage({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    // Función para compartir información del personaje
    void shareCharacter(Map<String, dynamic> character) {
      final String characterDetails = '''
Nombre: ${character['name']}

Descripción:
${character['description']}
      ''';

      if (character['image'] != null && character['image'].isNotEmpty) {
        // Compartir imagen junto con el texto
        Share.share(
          characterDetails,
          subject: 'Detalles del personaje: ${character['name']}',
        );
      } else {
        // Compartir solo texto si no hay imagen
        Share.share(
          characterDetails,
          subject: 'Detalles del personaje: ${character['name']}',
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Personaje'),
        actions: [
          FutureBuilder<Map<String, dynamic>>(
            future: service.fetchCharacterById(characterId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final character = snapshot.data!;
                return IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => shareCharacter(character),
                );
              }
              return Container(); // Botón vacío mientras se cargan los datos
            },
          ),
        ],
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
                  character['image'] != null && character['image'].isNotEmpty
                      ? Image.network(
                          character['image'],
                          errorBuilder: (context, error, stackTrace) =>
                              const Placeholder(),
                        )
                      : const Placeholder(fallbackHeight: 200),
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

/*
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
*/