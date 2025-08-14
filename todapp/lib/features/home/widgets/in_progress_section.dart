import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InProgressSection extends StatelessWidget {
  final List<Map<String, dynamic>> inProgressTasks;
  final VoidCallback updateTaskCounts;

  const InProgressSection({
    super.key,
    required this.inProgressTasks,
    required this.updateTaskCounts,
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
              bool isWorkTask = task["type"] == "Work";

              return GestureDetector(
                onTap: () {
                  
                  task["isCompleted"] = true;
                  updateTaskCounts();
                },
                child: Container(
                  width: 250,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isWorkTask
                        ? task["color"]
                        : task["color"].withOpacity(.3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${task["type"]} Task",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isWorkTask ? Colors.white : Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 30,
                            decoration: BoxDecoration(
                              color: isWorkTask ? Colors.green : task["color"],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              task["icon"],
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task["title"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: isWorkTask ? Colors.white : Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                     
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
