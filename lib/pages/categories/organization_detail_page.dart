import 'package:flutter/material.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class OrganizationDetailPage extends StatelessWidget {
  final String organizationId;

  const OrganizationDetailPage({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    final service = StarWarsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: service.fetchOrganizationById(organizationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final organization = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(organization['image']),
                  const SizedBox(height: 16),
                  Text(
                    organization['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(organization['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
