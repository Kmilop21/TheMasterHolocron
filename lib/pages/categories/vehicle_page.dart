import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/pages/categories/vehicle_details_page.dart';
import 'package:the_master_holocron/services/providers/vehicles_provider.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  VehiclesPageState createState() => VehiclesPageState();
}

class VehiclesPageState extends State<VehiclesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch vehicles data after the first frame has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<VehicleProvider>(context, listen: false);
      if (provider.vehicles == null && !provider.isLoading) {
        provider.fetchVehicles();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Vehicles"),
      ),
      body: Consumer<VehicleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text("Error: ${provider.error}"));
          } else if (provider.vehicles == null) {
            return const Center(child: Text("No vehicles found"));
          } else {
            final vehicles = provider.vehicles!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VehicleDetailPage(
                            vehicleId: vehicle['_id'].toString(),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              child: Image.network(
                                vehicle['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image, size: 48),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  vehicle['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
