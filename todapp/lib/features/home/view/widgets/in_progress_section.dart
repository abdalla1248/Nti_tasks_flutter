import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../tasks/data/model/task_model.dart';

class InProgressSection extends StatelessWidget {
  final List<TaskModel> inProgressTasks;
  final void Function(TaskModel task) markCompleted;

  const InProgressSection({
    super.key,
    required this.inProgressTasks,
    required this.markCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: EdgeInsets.all(26.0.h),
          child: Row(
            children: [
              const Text(
                "In Progress",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "${inProgressTasks.length}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Tasks list
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: inProgressTasks.length,
            itemBuilder: (context, index) {
              final task = inProgressTasks[index];
              final cardColor = _getCardColor(task.type);
              final iconBgColor = _getIconBgColor(task.type);

              return Container(
                width: 250,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${task.type} Task",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: task.type == "Work" ? Colors.white : Colors.black87,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 30,
                          decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            _getIconForType(task.type),
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      task.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: task.type == "Work" ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getIconForType(String? type) {
    switch (type) {
      case "Home":
        return Icons.home;
      case "Personal":
        return Icons.person;
      case "Work":
        return Icons.work;
      default:
        return Icons.task;
    }
  }

  Color _getCardColor(String? type) {
    switch (type) {
      case "Home":
        return Colors.pinkAccent.shade100;
      case "Personal":
        return Colors.green.shade100;
      case "Work":
        return Colors.black;
      default:
        return Colors.grey.shade200;
    }
  }

  Color _getIconBgColor(String? type) {
    switch (type) {
      case "Home":
        return Colors.pinkAccent;
      case "Personal":
        return Colors.green;
      case "Work":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
