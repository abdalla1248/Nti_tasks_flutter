import 'package:flutter/material.dart';
import 'TaskCard.dart';

class TaskListView extends StatelessWidget {
  final List<Map<String, dynamic>> tasks;
  final Color Function(String) getStatusColor;
  final Function(Map<String, dynamic>) onTapTask;

  const TaskListView({
    super.key,
    required this.tasks,
    required this.getStatusColor,
    required this.onTapTask,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: tasks[index],
          getStatusColor: getStatusColor,
          onTap: () => onTapTask(tasks[index]),
        );
      },
    );
  }
}
