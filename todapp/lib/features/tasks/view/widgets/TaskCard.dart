import 'package:flutter/material.dart';
import 'package:todapp/features/tasks/data/model/task_model.dart';
import '../../../../core/utils/app_assets.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final Color Function(TaskModel) getStatusColor;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.getStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final isCompleted = task.isDone;
    final isMissed = !isCompleted && task.createdAt.toDate().isBefore(today);
    final status = isMissed ? 'Missed' : (isCompleted ? 'Done' : 'In Progress');
    final statusColor = isMissed
        ? Colors.red
        : (isCompleted ? Colors.green : Colors.green.withOpacity(0.7));
    final statusIcon = isMissed
        ? Icons.error_outline
        : (isCompleted ? Icons.check_circle : Icons.timelapse);
    final typeIcon = task.type == 'Home'
        ? Icons.home
        : task.type == 'Personal'
            ? Icons.person
            : Icons.work_outline_outlined;
    final typeColor = task.type == 'Home'
        ? Colors.pink
        : task.type == 'Personal'
            ? Colors.green
            : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppAssets.flag,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(typeIcon, color: typeColor, size: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
