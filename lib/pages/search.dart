import 'package:flutter/material.dart';
import 'package:the_master_holocron/pages/categories/character_detail_page.dart';
import 'package:the_master_holocron/services/swd_service.dart';

class SearchPage extends StatefulWidget {
  final StarWarsService service;

  const SearchPage({required this.service, super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<Map<String, dynamic>>? _searchFuture;

  void _performSearch(String query) {
    setState(() {
      _searchFuture = widget.service.searchCharacterByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          decoration: const InputDecoration(
            hintText: "Buscar personaje...",
            hintStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
      ),
      body: _searchFuture == null
          ? const Center(
              child: Text(
                "Escribe un nombre para buscar un personaje.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No se encontró el personaje."),
                  );
                } else {
                  final character = snapshot.data!;
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailPage(
                              characterId: character['_id'],
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              character['image'],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image,
                                    size: 100);
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            character['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}

/*
class SearchPage extends StatefulWidget {
  final StarWarsService service;

  const SearchPage({required this.service, Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<Map<String, dynamic>>? _searchFuture;

  void _performSearch(String query) {
    setState(() {
      _searchFuture = widget.service.searchCharacterByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          decoration: const InputDecoration(
            hintText: "Buscar personaje...",
            hintStyle: TextStyle(color: Color.fromARGB(179, 5, 0, 0)),
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
      ),
      body: _searchFuture == null
          ? const Center(
              child: Text(
                "Escribe un nombre para buscar un personaje.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : FutureBuilder<Map<String, dynamic>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No se encontró el personaje."),
                  );
                } else {
                  final character = snapshot.data!;
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            character['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image, size: 100);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          character['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }
}
*/
/*
class SearchPage extends StatefulWidget {
  final StarWarsService service;

  const SearchPage({required this.service, Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? _searchFuture;

  void _performSearch(String query) {
    setState(() {
      _searchFuture = widget.service.searchCharactersByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Buscar personajes...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
      ),
      body: _searchFuture == null
          ? const Center(
              child: Text(
                "Escribe un nombre para buscar personajes.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : FutureBuilder<List<dynamic>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No se encontraron personajes."),
                  );
                } else {
                  final results = snapshot.data!;
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final character = results[index];
                      return Card(
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
                                  character['image'],
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
                              child: Center(
                                child: Text(
                                  character['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
*/

/*
class SearchPage extends StatefulWidget {
  final StarWarsService service;

  const SearchPage({required this.service, Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<dynamic>>? _searchFuture;

  void _performSearch(String query) {
    setState(() {
      _searchFuture = widget.service.searchCharactersByName(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          decoration: const InputDecoration(
            hintText: "Buscar personajes...",
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onSubmitted: _performSearch,
        ),
      ),
      body: _searchFuture == null
          ? const Center(
              child: Text(
                "Escribe un nombre para buscar personajes.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : FutureBuilder<List<dynamic>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No se encontraron personajes."),
                  );
                } else {
                  final results = snapshot.data!;
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final character = results[index];
                      return ListTile(
                        leading: Image.network(
                          character['image'],
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image);
                          },
                        ),
                        title: Text(character['name']),
                        subtitle: Text(character['description'] ?? ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CharacterDetailPage(
                                characterId: character['_id'].toString(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
    );
  }
}
*/

/*
class SearchResultsPage extends StatelessWidget {
  final String query;
  final Future<List<dynamic>> searchResults;

  SearchResultsPage({required this.query, required this.searchResults, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados para "$query"'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron personajes.'),
            );
          } else {
            final results = snapshot.data!;

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final character = results[index];
                return ListTile(
                  leading: Image.network(
                    character['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image);
                    },
                  ),
                  title: Text(character['name']),
                  subtitle: Text(character['description'] ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(
                          characterId: character['_id'].toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
*/

/*
class SearchResultsPage extends StatelessWidget {
  final String query;
  final StarWarsService service = StarWarsService();

  SearchResultsPage({required this.query, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados para "$query"'),
      ),
      body: FutureBuilder(
        future: service.searchCharactersByName(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final results = snapshot.data as List;

            if (results.isEmpty) {
              return const Center(
                child: Text('No se encontraron personajes.'),
              );
            }

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final character = results[index];
                return ListTile(
                  leading: Image.network(
                    character['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image);
                    },
                  ),
                  title: Text(character['name']),
                  subtitle: Text(character['description'] ?? ''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(
                          characterId: character['_id'].toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
*/