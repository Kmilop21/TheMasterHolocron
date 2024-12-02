import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/droids_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class DroidDetailPage extends StatefulWidget {
  final String droidId;

  const DroidDetailPage({super.key, required this.droidId});

  @override
  State<DroidDetailPage> createState() => _DroidDetailPageState();
}

class _DroidDetailPageState extends State<DroidDetailPage> {
  SWEntity? _droid;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadDroid();
    _checkFavoriteStatus();
  }

  Future<void> _loadDroid() async {
    final provider = Provider.of<DroidProvider>(context, listen: false);

    // Check if droid data is already in the provider
    final localDroid = provider.droids?.firstWhere(
      (droid) => droid['_id'] == widget.droidId,
      orElse: () => null,
    );

    if (localDroid != null) {
      setState(() {
        _droid = SWEntity.fromJson(localDroid, "droid");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedDroid = await provider.fetchDroidById(widget.droidId);
      setState(() {
        _droid = SWEntity.fromJson(fetchedDroid, "droid");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_droid == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_droid!.id, "droid");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_droid == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_droid!.id, "droid");
    } else {
      await db.addFavorite(_droid!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Droid Details'),
        actions: [
          if (_droid != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _droid != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_droid!.image),
                  const SizedBox(height: 16),
                  Text(
                    _droid!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_droid!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
