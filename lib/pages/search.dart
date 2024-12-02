import 'package:flutter/material.dart';
import 'package:the_master_holocron/pages/categories/character_detail_page.dart';
import 'package:the_master_holocron/pages/categories/creature_detail_page.dart';
import 'package:the_master_holocron/pages/categories/droid_detail_page.dart';
import 'package:the_master_holocron/pages/categories/location_detail_page.dart';
import 'package:the_master_holocron/pages/categories/organization_detail_page.dart';
import 'package:the_master_holocron/pages/categories/specie_detail_page.dart';
import 'package:the_master_holocron/pages/categories/vehicle_details_page.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class SearchPage extends StatefulWidget {
  final StarWarsService service;
  final String category; // Nueva propiedad para indicar la categoría

  const SearchPage({
    required this.service,
    required this.category,
    super.key,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<Map<String, dynamic>>? _searchFuture;

  // Método para llamar al método de búsqueda según la categoría
  Future<Map<String, dynamic>> _performSearch(String query) {
    switch (widget.category) {
      case 'characters':
        return widget.service.searchCharacterByName(query);
      case 'creatures':
        return widget.service.searchCreatureByName(query);
      case 'droids':
        return widget.service.searchDroidByName(query);
      case 'organizations':
        return widget.service.searchOrganizationsByName(query);
      case 'locations':
        return widget.service.searchLocationsByName(query);
      case 'species':
        return widget.service.searchSpeciesByName(query);
      case 'vehicles':
        return widget.service.searchVehiclesByName(query);
      default:
        throw Exception("Categoría no soportada: ${widget.category}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: "Buscar...",
            hintStyle: TextStyle(color: Colors.black45),
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            setState(() {
              _searchFuture = _performSearch(query);
            });
          },
        ),
      ),
      body: _searchFuture == null
          ? const Center(
              child: Text(
                "Escribe un nombre para buscar.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No se encontró nada."),
                  );
                } else {
                  final result = snapshot.data!;
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => _detailPage(result),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              result['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image,
                                    size: 100);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            result['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }

  // Método para seleccionar la página de detalle correcta
  Widget _detailPage(Map<String, dynamic> result) {
    switch (widget.category) {
      case 'characters':
      //return CharacterDetailPage(characterId: result['_id']);
      case 'creatures':
        return CreatureDetailPage(creatureId: result['_id']);
      case 'droids':
        return DroidDetailPage(droidId: result['_id']);
      case 'organizations':
        return OrganizationDetailPage(organizationId: result['_id']);
      case 'locations':
        return LocationDetailPage(locationId: result['_id']);
      case 'species':
        return SpeciesDetailPage(speciesId: result['_id']);
      case 'vehicles':
        return VehicleDetailPage(vehicleId: result['_id']);
      // Agrega las demás categorías si tienen páginas de detalle
      default:
        return Scaffold(
          appBar: AppBar(title: const Text("Detalles")),
          body: Center(child: Text("Detalles de ${result['name']}")),
        );
    }
  }
}
