import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CharacterList extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  CharacterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Star Wars Characters")),
      body: FutureBuilder(
        future: service.fetchCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final characters = snapshot.data as List;

            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  leading: Image.network(character['image']),
                  title: Text(character['name']),
                  subtitle: Text(character['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
