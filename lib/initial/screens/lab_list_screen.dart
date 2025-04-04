import 'package:flutter/material.dart';
import 'package:flutter_labs/initial/entities/lab.dart';
import 'package:flutter_labs/initial/screens/task_list_screen.dart';

class LabListScreen extends StatelessWidget {
  const LabListScreen({super.key});

  final List<Lab> labs = const [
    Lab(1, "Lab 1"),
    Lab(2, "Lab 2"),
    Lab(3, "Lab 3"),
    Lab(4, "Lab 4"),
    Lab(5, "Lab 5"),
    Lab(6, "Lab 6"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lab List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: labs.map((lab) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskListScreen(lab: lab),
                    ),
                  );
                },
                child: Text("Go to ${lab.name}"),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}