part of 'view_tasks_cubit.dart';

class ViewTasksState {
  final List<TaskModel> tasks;
  final List<TaskModel> filteredTasks;

  ViewTasksState({required this.tasks, required this.filteredTasks});

  ViewTasksState copyWith({
    List<TaskModel>? tasks,
    List<TaskModel>? filteredTasks,
  }) {
    return ViewTasksState(
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
    );
  }
}

class ViewTasksInitial extends ViewTasksState {
  ViewTasksInitial({required List<TaskModel> tasks})
      : super(tasks: tasks, filteredTasks: tasks);
}
