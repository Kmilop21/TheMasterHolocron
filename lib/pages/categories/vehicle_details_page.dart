import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class VehicleDetailsPage extends StatelessWidget {
  final String vehicleId;

  const VehicleDetailsPage({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchVehicleById(vehicleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final vehicle = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(vehicle['image']),
                  const SizedBox(height: 16),
                  Text(
                    vehicle['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(vehicle['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
