import 'package:flutter/material.dart';

class DiaryWidget extends StatefulWidget {
  @override
  _DiaryWidgetState createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  final List<String> _diaryEntries = [];
  final _entryController = TextEditingController();

  void _addEntry() {
    final entry = _entryController.text;

    if (entry.isNotEmpty) {
      setState(() {
        _diaryEntries.add(entry);
      });
      _entryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diary',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromRGBO(13, 21, 60, 1),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Write a New Entry',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromRGBO(13, 21, 60, 1),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _entryController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your diary entry here...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _addEntry,
                child: const Text('  Add Entry  '
                ,style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(13, 21, 60, 1),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _diaryEntries.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          _diaryEntries[index],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
