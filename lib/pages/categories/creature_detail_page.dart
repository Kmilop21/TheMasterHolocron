import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/creatures_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class CreatureDetailPage extends StatefulWidget {
  final String creatureId;

  const CreatureDetailPage({super.key, required this.creatureId});

  @override
  State<CreatureDetailPage> createState() => _CreatureDetailPageState();
}

class _CreatureDetailPageState extends State<CreatureDetailPage> {
  SWEntity? _creature;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadCreature();
    _checkFavoriteStatus();
  }

  Future<void> _loadCreature() async {
    final provider = Provider.of<CreatureProvider>(context, listen: false);

    // Check if creature data is already in the provider
    final localCreature = provider.creatures?.firstWhere(
      (creature) => creature['_id'] == widget.creatureId,
      orElse: () => null,
    );

    if (localCreature != null) {
      setState(() {
        _creature = SWEntity.fromJson(localCreature, "creature");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedCreature =
          await provider.fetchCreatureById(widget.creatureId);
      setState(() {
        _creature = SWEntity.fromJson(fetchedCreature, "creature");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_creature == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_creature!.id, "creature");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_creature == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_creature!.id, "creature");
    } else {
      await db.addFavorite(_creature!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creature Details'),
        actions: [
          if (_creature != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _creature != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_creature!.image),
                  const SizedBox(height: 16),
                  Text(
                    _creature!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_creature!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
