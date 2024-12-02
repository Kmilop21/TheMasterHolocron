import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/species_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class SpeciesDetailPage extends StatefulWidget {
  final String speciesId;

  const SpeciesDetailPage({super.key, required this.speciesId});

  @override
  State<SpeciesDetailPage> createState() => _SpeciesDetailPageState();
}

class _SpeciesDetailPageState extends State<SpeciesDetailPage> {
  SWEntity? _species;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadSpecies();
    _checkFavoriteStatus();
  }

  Future<void> _loadSpecies() async {
    final provider = Provider.of<SpecieProvider>(context, listen: false);

    // Check if species data is already in the provider
    final localSpecies = provider.species?.firstWhere(
      (specie) => specie['_id'] == widget.speciesId,
      orElse: () => null,
    );

    if (localSpecies != null) {
      setState(() {
        _species = SWEntity.fromJson(localSpecies, "species");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedSpecies = await provider.fetchSpecieById(widget.speciesId);
      setState(() {
        _species = SWEntity.fromJson(fetchedSpecies, "species");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_species == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_species!.id, "species");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_species == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_species!.id, "specie");
    } else {
      await db.addFavorite(_species!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Species Details'),
        actions: [
          if (_species != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _species != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_species!.image),
                  const SizedBox(height: 16),
                  Text(
                    _species!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_species!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
