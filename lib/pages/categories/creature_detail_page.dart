import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/creatures_provider.dart';

class CreatureDetailPage extends StatelessWidget {
  final String creatureId;

  const CreatureDetailPage({super.key, required this.creatureId});

  @override
  Widget build(BuildContext context) {
    // Use the CreatureProvider from the context
    final provider = Provider.of<CreatureProvider>(context, listen: false);

    // Check if the creature data is already in the provider
    final creature = provider.creatures?.firstWhere(
      (creature) => creature['_id'] == creatureId,
      orElse: () => null, // Return null if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creature Details'),
      ),
      body: creature != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(creature['image']),
                  const SizedBox(height: 16),
                  Text(
                    creature['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(creature['description']),
                ],
              ),
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: provider.fetchCreatureById(creatureId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final creature = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(creature['image']),
                        const SizedBox(height: 16),
                        Text(
                          creature['name'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(creature['description']),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("Creature not found"));
                }
              },
            ),
    );
  }
}
