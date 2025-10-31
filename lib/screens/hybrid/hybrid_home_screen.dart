import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/db_helper.dart';

class HybridHomeScreen extends StatefulWidget {
  const HybridHomeScreen({super.key});

  @override
  State<HybridHomeScreen> createState() => _HybridHomeScreenState();
}

class _HybridHomeScreenState extends State<HybridHomeScreen> {
  bool _isDark = false;
  double _fontSize = 16;
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _refreshNotes();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = prefs.getBool('isDark') ?? false;
      _fontSize = prefs.getDouble('fontSize') ?? 16;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', _isDark);
    await prefs.setDouble('fontSize', _fontSize);
  }

  void _refreshNotes() async {
    final data = await DBHelper.getNotes();
    setState(() => notes = data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: const Text('Hybrid Storage')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: _isDark,
                onChanged: (v) {
                  setState(() => _isDark = v);
                  _saveSettings();
                },
              ),
              Row(
                children: [
                  const Text('Font Size:'),
                  Expanded(
                    child: Slider(
                      min: 12,
                      max: 30,
                      value: _fontSize,
                      onChanged: (v) {
                        setState(() => _fontSize = v);
                        _saveSettings();
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (ctx, i) => ListTile(
                    title: Text(
                      notes[i]['title'],
                      style: TextStyle(fontSize: _fontSize),
                    ),
                    subtitle: Text(
                      notes[i]['content'],
                      style: TextStyle(fontSize: _fontSize - 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
