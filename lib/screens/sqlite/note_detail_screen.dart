import 'package:flutter/material.dart';
import '../../data/db_helper.dart';

class NoteDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? note;
  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'];
      _contentController.text = widget.note!['content'];
    }
  }

  void _saveNote() async {
    if (widget.note == null) {
      await DBHelper.insert({
        'title': _titleController.text,
        'content': _contentController.text,
      });
    } else {
      await DBHelper.update(widget.note!['id'], {
        'title': _titleController.text,
        'content': _contentController.text,
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          IconButton(onPressed: _saveNote, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
