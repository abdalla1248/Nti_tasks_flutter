import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tasks/data/model/task_model.dart';
import '../../tasks/data/repo/task_repo.dart';

part 'view_tasks_state.dart';

class ViewTasksCubit extends Cubit<ViewTasksState> {
  final TaskRepo _taskRepo = TaskRepo(); // Singleton instance

  ViewTasksCubit({required List<TaskModel> initialTasks})
      : super(ViewTasksInitial(tasks: initialTasks));

  // Search tasks by query
  void searchTasks(String query) {
    final filtered = query.isEmpty
        ? state.tasks
        : state.tasks.where((task) {
            final q = query.toLowerCase();
            return task.title.toLowerCase().contains(q) ||
                task.description.toLowerCase().contains(q) ||
                task.type.toLowerCase().contains(q);
          }).toList();

    emit(state.copyWith(
      searchQuery: query,
      filteredTasks: filtered,
    ));
  }

  // Filter tasks by category, status, date, or time
  void filterTasks({
    String category = 'All',
    String status = 'All',
    DateTime? date,
    TimeOfDay? time,
  }) {
    List<TaskModel> filtered = List.from(state.tasks);

    // Filter by category/type
    if (category != 'All') {
      filtered = filtered.where((task) => task.type == category).toList();
    }

    // Filter by status
    if (status != 'All') {
      filtered = filtered.where((task) {
        final now = DateTime.now();
        final taskDate = task.taskDateTime;
        final isCompleted = task.isDone;

        // Compare only date (ignore time)
        final today = DateTime(now.year, now.month, now.day);
        final taskDay = DateTime(taskDate.year, taskDate.month, taskDate.day);

        final isMissed = !isCompleted && taskDay.isBefore(today);

        if (status == 'Done') return isCompleted;
        if (status == 'In Progress') {
          return !isCompleted && !taskDay.isBefore(today);
        }
        if (status == 'Missed') return isMissed;
        return true;
      }).toList();
    }

    // Filter by specific date
    if (date != null) {
      filtered = filtered.where((task) {
        final taskDate = task.taskDateTime;
        return taskDate.year == date.year &&
            taskDate.month == date.month &&
            taskDate.day == date.day;
      }).toList();
    }

    emit(state.copyWith(filteredTasks: filtered));
  }

  // Update a task in the list
  void updateTask(TaskModel updatedTask) {
    final updatedList = state.tasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();

    // Remove duplicate tasks based on their ID
    final uniqueTasks = updatedList.toSet().toList();

    emit(state.copyWith(tasks: uniqueTasks, filteredTasks: uniqueTasks));
  }

// Delete a task from the list
  Future<void> deleteTask(String taskId) async {
    // Update local state
    final updatedTasks = state.tasks.where((t) => t.id != taskId).toList();
    emit(state.copyWith(
      tasks: updatedTasks,
      filteredTasks: updatedTasks,
    ));

    try {
      // 2. Delete from Firestore
      await _taskRepo.deleteTask(taskId);
    } catch (e) {
      debugPrint('Error deleting task: $e');

      // 3. If delete fails, reload tasks from backend
      final userId = state.tasks.isNotEmpty ? state.tasks.first.userId : '';
      if (userId.isNotEmpty) {
        await loadTasks(userId);
      }
      emit(ViewTasksError(e.toString()));
    }
  }

  Future<void> loadTasks(String userId) async {
    final result = await _taskRepo.getTasks(userId);
    result.fold(
      (error) => debugPrint('Error loading tasks: $error'),
      (tasks) {
        // Remove duplicate tasks based on their ID
        final uniqueTasks = tasks.toSet().toList();
        emit(state.copyWith(tasks: uniqueTasks, filteredTasks: uniqueTasks));
      },
    );
  }
}
