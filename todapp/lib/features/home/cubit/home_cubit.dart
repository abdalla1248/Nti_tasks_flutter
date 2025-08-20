// home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List<Map<String, dynamic>> _tasks = [];
  final List<Map<String, dynamic>> _taskTypes = [
    {"title": "Home", "icon": Icons.home, "color": Colors.pink, "count": 0},
    {"title": "Personal", "icon": Icons.person, "color": Colors.green, "count": 0},
    {"title": "Work", "icon": Icons.work, "color": Colors.black, "count": 0},
  ];

  List<Map<String, dynamic>> get tasks => _tasks;
  List<Map<String, dynamic>> get taskTypes => _taskTypes;

  double get progressPercentage {
    if (_tasks.isEmpty) return 0.0;
    int completedTasks = _tasks.where((task) => task["isCompleted"]).length;
    return (completedTasks / _tasks.length) * 100;
  }

  List<Map<String, dynamic>> get inProgressTasks =>
      _tasks.where((task) => !task["isCompleted"]).toList();

  void addTask(Map<String, dynamic> task) {
    _tasks.add(task);
    _updateTaskCounts();
    emit(HomeUpdated());
  }

  void markTaskCompleted(int index) {
    _tasks[index]["isCompleted"] = true;
    _updateTaskCounts();
    emit(HomeUpdated());
  }

  void _updateTaskCounts() {
    for (var type in _taskTypes) {
      type["count"] = _tasks.where((task) => task["type"] == type["title"]).length;
    }
  }
}
