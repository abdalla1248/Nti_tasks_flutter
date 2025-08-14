import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';

class TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  final VoidCallback onTap;
  final Color Function(String) getStatusColor;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.getStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final rawDate = task['date'];

    DateTime taskDate;
    if (rawDate is DateTime) {
      taskDate = rawDate;
    } else if (rawDate is String) {
      try {
        if (rawDate.contains('/')) {
          final p = rawDate.split('/');
          taskDate = DateTime(
            int.tryParse(p[2]) ?? DateTime.now().year,
            int.tryParse(p[1]) ?? DateTime.now().month,
            int.tryParse(p[0]) ?? DateTime.now().day,
          );
        } else {
          taskDate = DateTime.parse(rawDate);
        }
      } catch (_) {
        taskDate = DateTime.now();
      }
    } else {
      taskDate = DateTime.now();
    }

    final bool isCompleted = task['isCompleted'] == true;
    final bool isMissed = !isCompleted && taskDate.isBefore(today);

    final status = isMissed ? 'Missed' : (isCompleted ? 'Done' : 'In Progress');
    final bool isProgress = !isCompleted;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 5,
                    offset: const Offset(0, 4),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage(AppAssets.flag),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task["description"],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isProgress ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Icon(task["icon"], color: task["color"], size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
