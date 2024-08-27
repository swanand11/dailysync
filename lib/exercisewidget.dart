import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

class ExerciseLogWidget extends StatefulWidget {
  @override
  _ExerciseLogWidgetState createState() => _ExerciseLogWidgetState();
}

class _ExerciseLogWidgetState extends State<ExerciseLogWidget> {
  final List<Map<String, String>> _exerciseLog = [];
  final _typeController = TextEditingController();
  final _durationController = TextEditingController();

  void _addExercise() {
    final type = _typeController.text;
    final duration = _durationController.text;

    if (type.isNotEmpty && duration.isNotEmpty) {
      setState(() {
        _exerciseLog.add({
          'type': type,
          'duration': duration,
        });
      });

      _typeController.clear();
      _durationController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFE0B2), // Pastel orange background color
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exercise Log',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _typeController,
            decoration: InputDecoration(
              labelText: 'Exercise Type',
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Only allows alphabets and spaces
            ],
          ),
          SizedBox(height: 10),
          TextField(
            controller: _durationController,
            decoration: InputDecoration(
              labelText: 'Duration (in mins)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Only allows numbers
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addExercise,
            child: Text('Add Exercise'),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _exerciseLog.length,
              itemBuilder: (context, index) {
                final exercise = _exerciseLog[index];
                return ListTile(
                  title: Text('${exercise['type']}'),
                  subtitle: Text('Duration: ${exercise['duration']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
