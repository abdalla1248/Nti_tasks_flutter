// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'EditTaskPage.dart';
import 'widgets/FilterButton.dart';
import 'widgets/ResultsHeader.dart';
import 'widgets/SearchBar.dart';
import 'widgets/task_list_view.dart';

class ViewTasksPage extends StatefulWidget {
  final List<Map<String, dynamic>> tasks;

  const ViewTasksPage({super.key, required this.tasks});

  @override
  State<ViewTasksPage> createState() => _ViewTasksPageState();
}

class _ViewTasksPageState extends State<ViewTasksPage> {
  List<Map<String, dynamic>> filteredTasks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTasks = List.from(widget.tasks);
  }

  void _searchTasks(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTasks = List.from(widget.tasks);
      } else {
        filteredTasks = widget.tasks.where((task) {
          return task["title"].toLowerCase().contains(query.toLowerCase()) ||
              task["description"].toLowerCase().contains(query.toLowerCase()) ||
              task["type"].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Progress":
        return Colors.green.withAlpha(100);
      case "Done":
        return Colors.green;
      case "Missed":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _updateTask(Map<String, dynamic> updatedTask, int index) {
    setState(() {
      widget.tasks[index] = updatedTask;
      filteredTasks = List.from(widget.tasks);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      widget.tasks.removeAt(index);
      filteredTasks = List.from(widget.tasks);
    });
  }

  void _showFilterDialog() {
    // You can keep your existing dialog implementation here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Tasks",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: _searchTasks,
          ),
          ResultsHeader(count: filteredTasks.length),
          const SizedBox(height: 16),
          Expanded(
            child: TaskListView(
              tasks: filteredTasks,
              getStatusColor: _getStatusColor,
              onTapTask: (task) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskPage(
                      task: task,
                      taskIndex: widget.tasks.indexOf(task),
                      onUpdate: _updateTask,
                      onDelete: _deleteTask,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FilterButton(onPressed: _showFilterDialog),
    );
  }
}
