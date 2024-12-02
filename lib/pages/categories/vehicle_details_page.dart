import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/vehicles_provider.dart';

class VehicleDetailPage extends StatelessWidget {
  final String vehicleId;

  const VehicleDetailPage({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    // Use the VehicleProvider from the context
    final provider = Provider.of<VehicleProvider>(context, listen: false);

    // Check if the vehicle data is already in the provider
    final vehicle = provider.vehicles?.firstWhere(
      (vehicle) => vehicle['_id'] == vehicleId,
      orElse: () => null, // Return null if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
      ),
      body: vehicle != null
          ? Padding(
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
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: provider.fetchVehicleById(vehicleId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
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
                } else {
                  return const Center(child: Text("Vehicle not found"));
                }
              },
            ),
    );
  }
}
