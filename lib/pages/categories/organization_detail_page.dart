import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/services/providers/organizations_provider.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

class OrganizationDetailPage extends StatefulWidget {
  final String organizationId;

  const OrganizationDetailPage({super.key, required this.organizationId});

  @override
  State<OrganizationDetailPage> createState() => _OrganizationDetailPageState();
}

class _OrganizationDetailPageState extends State<OrganizationDetailPage> {
  SWEntity? _organization;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadOrganization();
    _checkFavoriteStatus();
  }

  Future<void> _loadOrganization() async {
    final provider = Provider.of<OrganizationProvider>(context, listen: false);

    // Check if organization data is already in the provider
    final localOrganization = provider.organizations?.firstWhere(
      (org) => org['_id'] == widget.organizationId,
      orElse: () => null,
    );

    if (localOrganization != null) {
      setState(() {
        _organization = SWEntity.fromJson(localOrganization, "organization");
      });
    } else {
      // Fetch from API if not found in the provider
      final fetchedOrganization =
          await provider.fetchOrganizationById(widget.organizationId);
      setState(() {
        _organization = SWEntity.fromJson(fetchedOrganization, "organization");
      });
    }
  }

  Future<void> _checkFavoriteStatus() async {
    if (_organization == null) return;
    final db = FavoritesDatabase();
    final isFavorite = await db.isFavorite(_organization!.id, "organization");
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_organization == null) return;
    final db = FavoritesDatabase();

    if (_isFavorite) {
      await db.removeFavorite(_organization!.id, "organization");
    } else {
      await db.addFavorite(_organization!);
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Details'),
        actions: [
          if (_organization != null)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : null,
              ),
              onPressed: _toggleFavorite,
            ),
        ],
      ),
      body: _organization != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(_organization!.image),
                  const SizedBox(height: 16),
                  Text(
                    _organization!.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(_organization!.description),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
