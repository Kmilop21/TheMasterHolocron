import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/pages/categories/droid_detail_page.dart';
import 'package:the_master_holocron/services/providers/droids_provider.dart';
import 'package:the_master_holocron/pages/search.dart';
import 'package:the_master_holocron/services/swd_service.dart';


class DroidsPage extends StatefulWidget {
  
  final StarWarsService service = StarWarsService();
  DroidsPage({super.key});

  @override
  DroidsPageState createState() => DroidsPageState();
}

class DroidsPageState extends State<DroidsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch droids data after the first frame has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DroidProvider>(context, listen: false);
      if (provider.droids == null && !provider.isLoading) {
        provider.fetchDroids();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Droids"),

       actions: [
      
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                service: widget.service,
                category: 'droids',
              ),
            ),
          );
        },
      ),

      ],
      


      ),
      body: Consumer<DroidProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text("Error: ${provider.error}"));
          } else if (provider.droids == null) {
            return const Center(child: Text("No droids found"));
          } else {
            final droids = provider.droids!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: droids.length,
                itemBuilder: (context, index) {
                  final droid = droids[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DroidDetailPage(
                            droidId: droid['_id'].toString(),
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
                                droid['image'],
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
                                  droid['name'],
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
