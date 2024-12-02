import 'package:flutter/material.dart';
import 'package:the_master_holocron/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:the_master_holocron/services/swd_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = SWDataProvider();
  await provider.initializeDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (_) => provider,
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
