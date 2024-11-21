import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class OrganizationsPage extends StatelessWidget {
  final StarWarsService service = StarWarsService();

  OrganizationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Star Wars Organizations")),
      body: FutureBuilder(
        future: service.fetchOrganizations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final organizations = snapshot.data as List;

            return ListView.builder(
              itemCount: organizations.length,
              itemBuilder: (context, index) {
                final organization = organizations[index];
                return ListTile(
                  leading: Image.network(organization['image']),
                  title: Text(organization['name']),
                  subtitle: Text(organization['description']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
