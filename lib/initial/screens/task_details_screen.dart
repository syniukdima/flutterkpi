import 'package:flutter/material.dart';
import 'package:flutter_labs/initial/entities/task.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;
  final int labId;
  final Widget taskScreen;
  final String taskTitle;

  const TaskDetailsScreen({super.key, required this.task, required this.labId, required this.taskScreen, required this.taskTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(taskTitle)),
      body: Center(
        child: taskScreen,
      ),
    );
  }
}