import 'package:flutter/material.dart';
import 'screens/shared_prefs/username_screen.dart';
import 'screens/sqlite/notes_list_screen.dart';
import 'screens/shared_prefs/counter_screen.dart';
import 'screens/shared_prefs/dark_mode_screen.dart';

import 'screens/file_storage/file_storage_screen.dart';
import 'screens/hybrid/hybrid_home_screen.dart';


void main() {
  runApp(const PersistenceApp());
}

class PersistenceApp extends StatelessWidget {
  const PersistenceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Persistence Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      routes: {
  '/': (_) => const HomeMenuScreen(),
  '/username': (_) => const UsernameScreen(),
  '/counter': (_) => const CounterScreen(),
  '/darkmode': (_) => const DarkModeScreen(),
  '/notes': (_) => const NotesListScreen(),
  '/file': (_) => const FileStorageScreen(),
  '/hybrid': (_) => const HybridHomeScreen(),
},
    );
  }
}

class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persistence Demo Menu')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
            ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/username'),
            child: const Text('SharedPrefs: Username'),
            ),
            ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/counter'),
            child: const Text('SharedPrefs: Counter'),
            ),
            ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/darkmode'),
            child: const Text('SharedPrefs: Dark Mode'),
            ),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/username'),
              child: const Text('SharedPrefs: Username')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/notes'),
              child: const Text('SQLite: Notes App')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/file'),
              child: const Text('File Storage Demo')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/hybrid'),
              child: const Text('Hybrid Storage App')),
        ],
      ),
    );
  }
}
