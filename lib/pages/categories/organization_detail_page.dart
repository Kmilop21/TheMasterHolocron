import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/organizations_provider.dart';

class OrganizationDetailPage extends StatelessWidget {
  final String organizationId;

  const OrganizationDetailPage({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    // Use the OrganizationProvider from the context
    final provider = Provider.of<OrganizationProvider>(context, listen: false);

    // Check if the organization data is already in the provider
    final organization = provider.organizations?.firstWhere(
      (organization) => organization['_id'] == organizationId,
      orElse: () => null, // Return null if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Details'),
      ),
      body: organization != null
          ? Padding(
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
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: provider.fetchOrganizationById(organizationId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
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
                } else {
                  return const Center(child: Text("Organization not found"));
                }
              },
            ),
    );
  }
}
