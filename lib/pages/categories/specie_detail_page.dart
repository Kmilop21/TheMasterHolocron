import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class SpecieDetailPage extends StatelessWidget {
  final String specieId;

  const SpecieDetailPage({super.key, required this.specieId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Specie Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchSpeciesById(specieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
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
          }
        },
      ),
    );
  }
}
