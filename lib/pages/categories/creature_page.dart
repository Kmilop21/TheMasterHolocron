import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/pages/categories/creature_detail_page.dart';
import 'package:the_master_holocron/services/providers/creatures_provider.dart';
import 'package:the_master_holocron/pages/search.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class CreaturesPage extends StatefulWidget {
  
  final StarWarsService service = StarWarsService();
  CreaturesPage({super.key});

  @override
  CreaturesPageState createState() => CreaturesPageState();
}

class CreaturesPageState extends State<CreaturesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch creatures data after the first frame has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CreatureProvider>(context, listen: false);
      if (provider.creatures == null && !provider.isLoading) {
        provider.fetchCreatures();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Creatures"),

      actions: [
      
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                service: widget.service,
                category: 'creatures',
              ),
            ),
          );
        },
      ),

      ],

      ),
      body: Consumer<CreatureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text("Error: ${provider.error}"));
          } else if (provider.creatures == null) {
            return const Center(child: Text("No creatures found"));
          } else {
            final creatures = provider.creatures!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: creatures.length,
                itemBuilder: (context, index) {
                  final creature = creatures[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreatureDetailPage(
                            creatureId: creature['_id'].toString(),
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
                                creature['image'],
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
                                  creature['name'],
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
