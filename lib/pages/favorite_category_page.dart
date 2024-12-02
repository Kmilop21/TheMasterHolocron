import 'package:flutter/material.dart';
import 'package:the_master_holocron/models/sw_entity.dart';
import 'package:the_master_holocron/pages/entity_details_page.dart';
import 'package:the_master_holocron/services/favorites_db.dart';

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}

class FavoritesCategoryPage extends StatefulWidget {
  final String category;

  const FavoritesCategoryPage({super.key, required this.category});

  @override
  FavoritesCategoryPageState createState() => FavoritesCategoryPageState();
}

class FavoritesCategoryPageState extends State<FavoritesCategoryPage> {
  late Future<List<SWEntity>> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = _fetchFavorites();
  }

  Future<List<SWEntity>> _fetchFavorites() async {
    final db = FavoritesDatabase();
    return await db.fetchFavorites(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite ${widget.category.capitalize()}s'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder<List<SWEntity>>(
        future: _favorites,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites added yet.'));
          }
          final favorites = snapshot.data!;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final entity = favorites[index];
              return ListTile(
                title: Text(entity.name),
                leading: Image.network(entity.image),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntityDetailPage(
                        entity: entity,
                      ),
                    ),
                  ).then((value) {
                    if (value == true) {
                      setState(() {
                        _favorites = _fetchFavorites();
                      });
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
