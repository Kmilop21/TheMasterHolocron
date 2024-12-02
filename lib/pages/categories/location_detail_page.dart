import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/locations_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class LocationDetailPage extends StatefulWidget {
  final String locationId;

  const LocationDetailPage({super.key, required this.locationId});

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  SWEntity? _location;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadLocation();
    _checkFavoriteStatus();
  }

  Future<void> _loadLocation() async {
    final provider = Provider.of<LocationProvider>(context, listen: false);

    // Check if location data is already in the provider
    final localLocation = provider.locations?.firstWhere(
      (loc) => loc['_id'] == widget.locationId,
      orElse: () => null,
    );

    if (localLocation != null) {
      setState(() {
        _location = SWEntity.fromJson(localLocation, "location");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedLocation =
          await provider.fetchLocationById(widget.locationId);
      setState(() {
        _location = SWEntity.fromJson(fetchedLocation, "location");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_location == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_location!.id, "location");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_location == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_location!.id, "location");
    } else {
      await db.addFavorite(_location!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
        actions: [
          if (_location != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _location != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_location!.image),
                  const SizedBox(height: 16),
                  Text(
                    _location!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_location!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
