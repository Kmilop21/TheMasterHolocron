import 'package:flutter/material.dart';
import 'package:the_master_holocron/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/providers/character_provider.dart';
import 'package:the_master_holocron/services/providers/creature_provider.dart';
import 'package:the_master_holocron/services/providers/droid_provider.dart';
import 'package:the_master_holocron/services/providers/locations_provider.dart';
import 'package:the_master_holocron/services/providers/organizations_provider.dart';
import 'package:the_master_holocron/services/providers/species_provider.dart';
import 'package:the_master_holocron/services/providers/vehicles_provider.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        ChangeNotifierProvider(create: (context) => CreatureProvider()),
        ChangeNotifierProvider(create: (context) => DroidProvider()),
        ChangeNotifierProvider(create: (context) => OrganizationProvider()),
        ChangeNotifierProvider(create: (context) => LocationsProvider()),
        ChangeNotifierProvider(create: (context) => SpeciesProvider()),
        ChangeNotifierProvider(create: (context) => VehiclesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Master Holocron',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
