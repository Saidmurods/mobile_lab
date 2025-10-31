import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _savedUsername;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _savedUsername = prefs.getString('username'));
  }

  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controller.text);
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Save Username')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: const InputDecoration(labelText: 'Enter username')),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _saveUsername, child: const Text('Save')),
            const SizedBox(height: 20),
            Text('Saved Username: ${_savedUsername ?? "None"}'),
          ],
        ),
      ),
    );
  }
}
