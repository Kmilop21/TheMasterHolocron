import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class LocationDetailPage extends StatelessWidget {
  final String locationId;

  const LocationDetailPage({super.key, required this.locationId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchLocationsById(locationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final location = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(location['image']),
                  const SizedBox(height: 16),
                  Text(
                    location['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(location['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
