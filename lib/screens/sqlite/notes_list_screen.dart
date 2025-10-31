import 'package:flutter/material.dart';
import '../../data/db_helper.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  List<Map<String, dynamic>> notes = [];

  void _refreshNotes() async {
    final data = await DBHelper.getNotes();
    setState(() => notes = data);
  }

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  void _delete(int id) async {
    await DBHelper.delete(id);
    _refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite Notes')),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(notes[i]['title']),
          subtitle: Text(notes[i]['content']),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NoteDetailScreen(note: notes[i]),
              ),
            );
            _refreshNotes();
          },
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _delete(notes[i]['id']),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NoteDetailScreen(),
            ),
          );
          _refreshNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
