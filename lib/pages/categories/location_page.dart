import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class LocationsPage extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Locations")),
      body: FutureBuilder(
        future: service.fetchLocations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final locations = snapshot.data as List;

            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return ListTile(
                  leading: Image.network(location['image']),
                  title: Text(location['name']),
                  subtitle: Text(location['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
