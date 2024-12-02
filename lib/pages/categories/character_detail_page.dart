import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/characters_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class CharacterDetailPage extends StatefulWidget {
  final String characterId;

  const CharacterDetailPage({super.key, required this.characterId});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  SWEntity? _character;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadCharacter();
    _checkFavoriteStatus();
  }

  Future<void> _loadCharacter() async {
    final provider = Provider.of<CharacterProvider>(context, listen: false);

    // Check if character data is already in the provider
    final localCharacter = provider.characters?.firstWhere(
      (char) => char['_id'] == widget.characterId,
      orElse: () => null,
    );

    if (localCharacter != null) {
      setState(() {
        _character = SWEntity.fromJson(localCharacter, "character");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedCharacter =
          await provider.fetchCharacterById(widget.characterId);
      setState(() {
        _character = SWEntity.fromJson(fetchedCharacter, "character");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_character == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_character!.id, "character");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_character == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_character!.id, "character");
    } else {
      await db.addFavorite(_character!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character Details'),
        actions: [
          if (_character != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _character != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_character!.image),
                  const SizedBox(height: 16),
                  Text(
                    _character!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_character!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
