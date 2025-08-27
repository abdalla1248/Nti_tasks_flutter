import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tasks/data/model/task_model.dart';

part 'view_tasks_state.dart';

class ViewTasksCubit extends Cubit<ViewTasksState> {
  ViewTasksCubit({required List<TaskModel> initialTasks})
      : super(ViewTasksInitial(tasks: initialTasks));

  // Search tasks by query
  void searchTasks(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(filteredTasks: state.tasks));
      return;
    }
    final filtered = state.tasks.where((task) {
      final q = query.toLowerCase();
      return task.title.toLowerCase().contains(q) ||
          task.description.toLowerCase().contains(q) ||
          task.type.toLowerCase().contains(q);
    }).toList();
    emit(state.copyWith(filteredTasks: filtered));
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
      final isMissed = !isCompleted && taskDate.isBefore(now);

      if (status == 'Done') return isCompleted;
      if (status == 'In Progress') return !isCompleted && !isMissed;
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

  // Filter by specific time
  if (time != null) {
    filtered = filtered.where((task) {
      final taskDate = task.taskDateTime;
      return taskDate.hour == time.hour && taskDate.minute == time.minute;
    }).toList();
  }

  emit(state.copyWith(filteredTasks: filtered));
}


  // Update a task in the list
  void updateTask(TaskModel updatedTask) {
    final updatedList = state.tasks.map((task) {
      return task.id == updatedTask.id ? updatedTask : task;
    }).toList();
    emit(state.copyWith(tasks: updatedList, filteredTasks: updatedList));
  }

  // Delete a task from the list
  void deleteTask(String taskId) {
    final updatedList =
        state.tasks.where((task) => task.id != taskId).toList();
    emit(state.copyWith(tasks: updatedList, filteredTasks: updatedList));
  }
}
