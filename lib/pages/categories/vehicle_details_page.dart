import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/vehicles_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class VehicleDetailPage extends StatefulWidget {
  final String vehicleId;

  const VehicleDetailPage({super.key, required this.vehicleId});

  @override
  State<VehicleDetailPage> createState() => _VehicleDetailPageState();
}

class _VehicleDetailPageState extends State<VehicleDetailPage> {
  SWEntity? _vehicle;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadVehicle();
    _checkFavoriteStatus();
  }

  Future<void> _loadVehicle() async {
    final provider = Provider.of<VehicleProvider>(context, listen: false);

    // Check if vehicle data is already in the provider
    final localVehicle = provider.vehicles?.firstWhere(
      (vehicle) => vehicle['_id'] == widget.vehicleId,
      orElse: () => null,
    );

    if (localVehicle != null) {
      setState(() {
        _vehicle = SWEntity.fromJson(localVehicle, "vehicle");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedVehicle = await provider.fetchVehicleById(widget.vehicleId);
      setState(() {
        _vehicle = SWEntity.fromJson(fetchedVehicle, "vehicle");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_vehicle == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_vehicle!.id, "vehicle");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_vehicle == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_vehicle!.id, "vehicle");
    } else {
      await db.addFavorite(_vehicle!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
        actions: [
          if (_vehicle != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _vehicle != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_vehicle!.image),
                  const SizedBox(height: 16),
                  Text(
                    _vehicle!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_vehicle!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
