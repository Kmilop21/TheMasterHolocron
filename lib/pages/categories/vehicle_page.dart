import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class VehiclesPage extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Vehicles")),
      body: FutureBuilder(
        future: service.fetchVehicles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final vehicles = snapshot.data as List;

            return ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return ListTile(
                  leading: Image.network(vehicle['image']),
                  title: Text(vehicle['name']),
                  subtitle: Text(vehicle['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
