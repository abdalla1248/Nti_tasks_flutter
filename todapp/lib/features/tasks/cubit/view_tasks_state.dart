part of 'view_tasks_cubit.dart';

class ViewTasksState {
  final List<TaskModel> tasks;
  final List<TaskModel> filteredTasks;
  final String searchQuery;

  ViewTasksState({required this.tasks, required this.filteredTasks, this.searchQuery = ''});

  ViewTasksState copyWith({
    List<TaskModel>? tasks,
    List<TaskModel>? filteredTasks,
    String? searchQuery,
  }) {
    return ViewTasksState(
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ViewTasksInitial extends ViewTasksState {
  ViewTasksInitial({required super.tasks})
      : super(filteredTasks: tasks);
}

class ViewTasksLoading extends ViewTasksState {
  ViewTasksLoading() : super(tasks: [], filteredTasks: []);
}

class ViewTasksLoaded extends ViewTasksState {
  ViewTasksLoaded({required List<TaskModel> tasks, required List<TaskModel> filteredTasks})
      : super(tasks: tasks, filteredTasks: filteredTasks);
}

class ViewTasksError extends ViewTasksState {
  final String error;

  ViewTasksError(this.error) : super(tasks: [], filteredTasks: []);
}
