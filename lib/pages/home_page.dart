import 'package:flutter/material.dart';
import 'package:the_master_holocron/pages/categories/character_page.dart';
import 'package:the_master_holocron/pages/categories/creature_page.dart';
import 'package:the_master_holocron/pages/categories/droid_page.dart';
import 'package:the_master_holocron/pages/categories/location_page.dart';
import 'package:the_master_holocron/pages/categories/organization_page.dart';
import 'package:the_master_holocron/pages/categories/specie_page.dart';
import 'package:the_master_holocron/pages/categories/vehicle_page.dart';
import 'package:the_master_holocron/pages/about.dart';



class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Characters",
      //"image": "assets/characters.jpg",
      "page": CharacterPage(),
    },
    {
      "name": "Creatures",
      //"image": "assets/characters.jpg",
      "page": CreaturesPage(),
    },
    {
      "name": "Droids",
      //"image": "assets/droids.jpg",
      "page": DroidsPage(),
    },
    {
      "name": "Organizations",
      //"image": "assets/organizations.jpg",
      "page": OrganizationsPage(),
    },
    {
      "name": "Locations",
      //"image": "assets/locations.jpg",
      "page": LocationsPage(),
    },
    {
      "name": "Species",
      //"image": "assets/species.jpg",
      "page": SpeciesPage(),
    },
    {
      "name": "Vehicles",
      //"image": "assets/vehicles.jpg",
      "page": VehiclesPage(),
    },

  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Star Wars Databank"),

        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
          ),
        ],

      ),
           
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards side by side
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) 
          
          
          
          {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => category['page']),
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
                    const Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(8)),
                        // child: Image.asset(
                        //   category['image'],
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          category['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
