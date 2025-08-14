import 'package:flutter/material.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/utils/app_colors.dart';
import '../../tasks/view/Addtask.dart';
import 'widgets/header_section.dart';
import 'widgets/progress_card.dart';
import 'widgets/in_progress_section.dart';
import 'widgets/task_groups_section.dart';
import 'widgets/empty_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.name, this.password});
  final String name;
  final String? password;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> tasks = [];

  final List<Map<String, dynamic>> taskTypes = [
    {"title": "Home", "icon": Icons.home, "color": Colors.pink, "count": 0},
    {"title": "Personal", "icon": Icons.person, "color": Colors.green, "count": 0},
    {"title": "Work", "icon": Icons.work, "color": Colors.black, "count": 0},
  ];

  @override
  void initState() {
    super.initState();
    _updateTaskCounts();
  }

  void _updateTaskCounts() {
    for (var type in taskTypes) {
      type["count"] =
          tasks.where((task) => task["type"] == type["title"]).length;
    }
  }

  double get _progressPercentage {
    if (tasks.isEmpty) return 0.0;
    int completedTasks = tasks.where((task) => task["isCompleted"]).length;
    return (completedTasks / tasks.length) * 100;
  }

  List<Map<String, dynamic>> get _inProgressTasks {
    return tasks.where((task) => !task["isCompleted"]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await AppNavigator.push(context, AddTaskScreen(tasks: tasks));
          if (result != null && result is Map<String, dynamic>) {
            setState(() {
              tasks.add(result);
              _updateTaskCounts();
            });
          }
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color:AppColors.card),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(name: widget.name, password: widget.password),
              if (tasks.isNotEmpty) ...[
                ProgressCard(progressPercentage: _progressPercentage, tasks: tasks),
                InProgressSection(
                  inProgressTasks: _inProgressTasks,
                  updateTaskCounts: _updateTaskCounts,
                ),
                TaskGroupsSection(taskTypes: taskTypes),
                const SizedBox(height: 80),
              ] else
                const EmptyState(),
            ],
          ),
        ),
      ),
    );
  }
}
