import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/swd_provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';

class CharacterDetailPage extends StatelessWidget {
  final SWEntity character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SWDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
        actions: [
          IconButton(
            icon: Icon(
              provider.isFavorite(character.id)
                  ? Icons.star
                  : Icons.star_border,
              color: provider.isFavorite(character.id) ? Colors.yellow : null,
            ),
            onPressed: () {
              if (provider.isFavorite(character.id)) {
                provider.removeFavorite(character);
              } else {
                provider.addFavorite(character);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(character.image),
            const SizedBox(height: 16),
            Text(
              character.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(character.description),
          ],
        ),
      ),
    );
  }
}
