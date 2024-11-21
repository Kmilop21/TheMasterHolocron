import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class DroidsPage extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  DroidsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Creatures")),
      body: FutureBuilder(
        future: service.fetchDroids(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final droids = snapshot.data as List;

            return ListView.builder(
              itemCount: droids.length,
              itemBuilder: (context, index) {
                final droid = droids[index];
                return ListTile(
                  leading: Image.network(droid['image']),
                  title: Text(droid['name']),
                  subtitle: Text(droid['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
