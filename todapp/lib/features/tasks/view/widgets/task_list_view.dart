import 'package:flutter/material.dart';
import 'package:todapp/features/tasks/data/model/task_model.dart';
import 'TaskCard.dart';

class TaskListView extends StatelessWidget {
  final List<TaskModel> tasks;
  final Color Function(TaskModel) getStatusColor;
  final Function(TaskModel) onTapTask;

  const TaskListView({
    super.key,
    required this.tasks,
    required this.getStatusColor,
    required this.onTapTask,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (_, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          getStatusColor: getStatusColor,
          onTap: () => onTapTask(task),
        );
      },
    );
  }
}
