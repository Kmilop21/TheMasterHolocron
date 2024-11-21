import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CreaturesPage extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  CreaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Creatures")),
      body: FutureBuilder(
        future: service.fetchCreatures(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final creatures = snapshot.data as List;

            return ListView.builder(
              itemCount: creatures.length,
              itemBuilder: (context, index) {
                final creature = creatures[index];
                return ListTile(
                  leading: Image.network(creature['image']),
                  title: Text(creature['name']),
                  subtitle: Text(creature['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
