import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class DroidDetailPage extends StatelessWidget {
  final String droidId;

  const DroidDetailPage({super.key, required this.droidId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Droid Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchDroidById(droidId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final droid = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(droid['image']),
                  const SizedBox(height: 16),
                  Text(
                    droid['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(droid['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
