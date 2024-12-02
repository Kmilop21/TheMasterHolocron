import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/species_provider.dart';

class SpecieDetailPage extends StatelessWidget {
  final String specieId;

  const SpecieDetailPage({super.key, required this.specieId});

  @override
  Widget build(BuildContext context) {
    // Use the SpecieProvider from the context
    final provider = Provider.of<SpecieProvider>(context, listen: false);

    // Check if the specie data is already in the provider
    final specie = provider.species?.firstWhere(
      (specie) => specie['_id'] == specieId,
      orElse: () => null, // Return null if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Specie Details'),
      ),
      body: specie != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(specie['image']),
                  const SizedBox(height: 16),
                  Text(
                    specie['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(specie['description']),
                ],
              ),
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: provider.fetchSpecieById(specieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final specie = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(specie['image']),
                        const SizedBox(height: 16),
                        Text(
                          specie['name'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(specie['description']),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("Specie not found"));
                }
              },
            ),
    );
  }
}
