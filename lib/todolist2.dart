import 'package:flutter/material.dart';

class ToDoListPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(13, 21, 60, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ToDoList2(),
    );
  }
}

class ToDoList2 extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList2> {
  final List<String> _tasks = [];
  final List<bool> _completed = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add(_controller.text);
        _completed.add(false); // Add a new entry for completion status
        _controller.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _completed[index] = !_completed[index]; // Toggle completion status
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _completed.removeAt(index); // Remove corresponding completion status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade200, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTaskInput(),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildTaskList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter a task',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
              hintStyle: TextStyle(color: Colors.grey.shade600),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(width: 8.0),
        ElevatedButton(
          onPressed: _addTask,
          child: const Icon(Icons.add, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(
              _tasks[index],
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                decoration: _completed[index]
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            leading: Checkbox(
              value: _completed[index],
              onChanged: (bool? value) {
                if (value != null) {
                  _toggleTask(index);
                }
              },
              checkColor: Colors.black,
              activeColor: Colors.blueAccent,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteTask(index);
              },
            ),
          ),
        );
      },
    );
  }
}
