import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/droids_provider.dart';

class DroidDetailPage extends StatelessWidget {
  final String droidId;

  const DroidDetailPage({super.key, required this.droidId});

  @override
  Widget build(BuildContext context) {
    // Use the DroidProvider from the context
    final provider = Provider.of<DroidProvider>(context, listen: false);

    // Check if the droid data is already in the provider
    final droid = provider.droids?.firstWhere(
      (droid) => droid['_id'] == droidId,
      orElse: () => null, // Return null if not found
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Droid Details'),
      ),
      body: droid != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(droid['image']),
                  const SizedBox(height: 16),
                  Text(
                    droid['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(droid['description']),
                ],
              ),
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: provider.fetchDroidById(droidId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final droid = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(droid['image']),
                        const SizedBox(height: 16),
                        Text(
                          droid['name'],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(droid['description']),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text("Droid not found"));
                }
              },
            ),
    );
  }
}
