import 'package:flutter/material.dart';
import 'package:the_master_holocron/pages/favorite_category_page.dart'; // Import the FavoritesCategoryPage

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Characters",
      "image": "assets/images/Characters.jpg",
      "category": "character", // Use category names (lowercase)
    },
    {
      "name": "Creatures",
      "image": "assets/images/Creatures.jpg",
      "category": "creature",
    },
    {
      "name": "Droids",
      "image": "assets/images/Droids.jpg",
      "category": "droid",
    },
    {
      "name": "Organizations",
      "image": "assets/images/Organizations.jpg",
      "category": "organization",
    },
    {
      "name": "Locations",
      "image": "assets/images/Localizations.jpg",
      "category": "location",
    },
    {
      "name": "Species",
      "image": "assets/images/Species.jpg",
      "category": "species",
    },
    {
      "name": "Vehicles",
      "image": "assets/images/Vehicles.jpg",
      "category": "vehicle",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.deepPurple,
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
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                // Navigate to FavoritesCategoryPage, passing the category name
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesCategoryPage(
                      category: category['category'], // Pass the category
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                color: const Color.fromARGB(255, 239, 239, 239),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8)),
                        child: Image.asset(
                          category['image'],
                          fit: BoxFit.cover,
                        ),
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
