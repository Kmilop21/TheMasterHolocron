import 'package:flutter/material.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class EntityDetailPage extends StatefulWidget {
  final SWEntity entity;

  const EntityDetailPage({super.key, required this.entity});

  @override
  State<EntityDetailPage> createState() => _EntityDetailPageState();
}

class _EntityDetailPageState extends State<EntityDetailPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  // Check if the entity is already marked as a favorite
  Future<void> _checkFavoriteStatus() async {
    final db = FavoritesDatabase();
    final isFavorite =
        await db.isFavorite(widget.entity.id, widget.entity.category);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  // Toggle the favorite status
  Future<void> _toggleFavorite() async {
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(widget.entity.id, widget.entity.category);
    } else {
      await db.addFavorite(widget.entity);
    }

    if (mounted) {
      setState(() {
        _isFavorite = !_isFavorite;
      });

      // Return true if there was a change (favorite added/removed)
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.entity.name} Details'),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.entity.image),
            const SizedBox(height: 16),
            Text(
              widget.entity.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.entity.description),
          ],
        ),
      ),
    );
  }
}
