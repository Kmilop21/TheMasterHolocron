import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CreatureDetailPage extends StatelessWidget {
  final String creatureId;

  const CreatureDetailPage({super.key, required this.creatureId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creature Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchCreatureById(creatureId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
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
          }
        },
      ),
    );
  }
}
