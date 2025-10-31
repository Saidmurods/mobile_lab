import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileStorageScreen extends StatefulWidget {
  const FileStorageScreen({super.key});

  @override
  State<FileStorageScreen> createState() => _FileStorageScreenState();
}

class _FileStorageScreenState extends State<FileStorageScreen> {
  String _content = '';

  Future<String> get _filePath async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/user_data.txt';
  }

  Future<void> _writeToFile() async {
    final file = File(await _filePath);
    await file.writeAsString('Hello from Flutter File Storage!');
  }

  Future<void> _readFile() async {
    final file = File(await _filePath);
    if (await file.exists()) {
      final text = await file.readAsString();
      setState(() => _content = text);
    } else {
      setState(() => _content = 'File not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Storage Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(onPressed: _writeToFile, child: const Text('Write to File')),
            ElevatedButton(onPressed: _readFile, child: const Text('Read File')),
            const SizedBox(height: 20),
            Text('File Content: $_content'),
          ],
        ),
      ),
    );
  }
}
