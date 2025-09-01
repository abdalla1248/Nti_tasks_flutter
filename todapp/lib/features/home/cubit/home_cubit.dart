import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../tasks/data/model/task_model.dart';
import '../../tasks/data/repo/task_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    _listenTasks();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<TaskModel> _tasks = [];
  final List<Map<String, dynamic>> _taskTypes = [
    {"title": "Home", "icon": Icons.home, "color": Colors.pink, "count": 0},
    {
      "title": "Personal",
      "icon": Icons.person,
      "color": Colors.green,
      "count": 0
    },
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

  /// Listen to Firestore tasks for the current user
  void _listenTasks() {
    final user = _auth.currentUser;
    if (user == null) return;

    _firestore
        .collection('tasks')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .listen((snapshot) {
      _tasks.clear();
      _tasks.addAll(snapshot.docs
          .map((doc) =>
              TaskModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList());

      _updateTaskCounts();
      emit(state.copyWith(tasks: List.from(_tasks)));
    });
  }

  /// Add a new task (Firestore handles updating the list automatically)
  Future<void> addTask(TaskModel task) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Always enforce the userId field
    final taskWithUser = task.copyWith(userId: user.uid);

    await TaskRepo().addTask(taskWithUser);
  }

  /// Update a task
  Future<void> markTaskCompleted(TaskModel task) async {
    final updatedTask = task.copyWith(isDone: true);
    await TaskRepo().updateTask(updatedTask);
    // Firestore listener will update _tasks automatically
  }

  void updateTask(TaskModel updatedTask) async {
    await TaskRepo().updateTask(updatedTask);
  }

  void deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
    emit(state.copyWith(tasks: List.from(_tasks)));

    try {
      await TaskRepo().deleteTask(taskId);
    } catch (e) {
      _listenTasks();
    }
  }

  void setUsername(String name) async {
    emit(state.copyWith(username: name));

    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection("users").doc(user.uid).set({
          "username": name,
          "email": user.email,
        }, SetOptions(merge: true));
      } catch (e) {
        debugPrint("Failed to save username in Firestore: $e");
      }
    }
  }

  void _updateTaskCounts() {
    for (var type in _taskTypes) {
      type["count"] = _tasks.where((t) => t.type == type["title"]).length;
    }
  }
}
