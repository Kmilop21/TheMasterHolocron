import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class SpeciesPage extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  SpeciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Species")),
      body: FutureBuilder(
        future: service.fetchSpecies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final species = snapshot.data as List;

            return ListView.builder(
              itemCount: species.length,
              itemBuilder: (context, index) {
                final specie = species[index];
                return ListTile(
                  leading: Image.network(specie['image']),
                  title: Text(specie['name']),
                  subtitle: Text(specie['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
