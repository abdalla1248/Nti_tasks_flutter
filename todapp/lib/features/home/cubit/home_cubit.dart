import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../tasks/data/model/task_model.dart';
import '../../tasks/data/repo/task_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<TaskModel> _tasks = [];
  final List<Map<String, dynamic>> _taskTypes = [
    {"title": "Home", "icon": Icons.home, "color": Colors.pink, "count": 0},
    {"title": "Personal", "icon": Icons.person, "color": Colors.green, "count": 0},
    {"title": "Work", "icon": Icons.work, "color": Colors.black, "count": 0},
  ];

  List<TaskModel> get tasks => _tasks;
  List<Map<String, dynamic>> get taskTypes => _taskTypes;

  double get progressPercentage {
    if (_tasks.isEmpty) return 0.0;
    final completed = _tasks.where((t) => t.isDone).length;
    return (completed / _tasks.length) * 100;
  }

  List<TaskModel> get inProgressTasks =>
      _tasks.where((t) => !t.isDone).toList();

  /// Load username and tasks together
  Future<void> loadData({String? savedUsername}) async {
    // 1️⃣ Set username first
    if (savedUsername != null) {
      emit(state.copyWith(username: savedUsername));
    }

    // 2️⃣ Load tasks from Firestore
    final user = _auth.currentUser;
    if (user == null) return;

    final result = await TaskRepo().getTasks(user.uid);
    result.fold(
      (error) => emit(state.copyWith(tasks: [])),
      (tasksFromDb) {
        _tasks.clear();
        _tasks.addAll(tasksFromDb);
        _updateTaskCounts();
        emit(state.copyWith(tasks: List.from(_tasks)));
      },
    );
  }

  /// Add a new task
  Future<void> addTask(TaskModel task) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final result = await TaskRepo().addTask(task.copyWith(userId: user.uid));
    result.fold(
      (error) => debugPrint("Error adding task: $error"),
      (newTask) {
        _tasks.add(newTask);
        _updateTaskCounts();
        emit(state.copyWith(tasks: List.from(_tasks)));
      },
    );
  }

  /// Mark task as completed
  Future<void> markTaskCompleted(TaskModel task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) return;

    final updatedTask = _tasks[index].copyWith(isDone: true);
    final result = await TaskRepo().updateTask(updatedTask);

    result.fold(
      (error) => debugPrint("Error updating task: $error"),
      (_) {
        _tasks[index] = updatedTask;
        _updateTaskCounts();
        emit(state.copyWith(tasks: List.from(_tasks)));
      },
    );
  }

  /// Update username locally
  void setUsername(String name) {
    emit(state.copyWith(username: name));
  }

  /// Update task counts per type
  void _updateTaskCounts() {
    for (var type in _taskTypes) {
      type["count"] = _tasks.where((t) => t.type == type["title"]).length;
    }
  }
}
