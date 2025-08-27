import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/task_model.dart';
import '../data/repo/task_repo.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepo _taskRepo = TaskRepo(); // Singleton instance

  TaskCubit() : super(TaskLoading());

  Future<void> loadTasks(String userId) async {
    emit(TaskLoading());
    final result = await _taskRepo.getTasks(userId);
    result.fold(
      (error) => emit(TaskError(error)),
      (tasks) => emit(TaskLoaded(tasks)),
    );
  }

  Future<void> addTask(TaskModel task) async {
    final result = await _taskRepo.addTask(task);
    result.fold(
      (error) => emit(TaskError(error)),
      (newTask) {
        if (state is TaskLoaded) {
          final updatedTasks = List<TaskModel>.from((state as TaskLoaded).tasks)
            ..add(newTask);
          emit(TaskLoaded(updatedTasks));
        }
      },
    );
  }

  Future<void> updateTask(TaskModel task) async {
    final result = await _taskRepo.updateTask(task);
    result.fold(
      (error) => emit(TaskError(error)),
      (_) {
        if (state is TaskLoaded) {
          final tasks = (state as TaskLoaded).tasks;
          final index = tasks.indexWhere((t) => t.id == task.id);
          if (index != -1) {
            final updatedTasks = List<TaskModel>.from(tasks);
            updatedTasks[index] = task;
            emit(TaskLoaded(updatedTasks));
          }
        }
      },
    );
  }

  Future<void> deleteTask(String taskId) async {
    final result = await _taskRepo.deleteTask(taskId);
    result.fold(
      (error) => emit(TaskError(error)),
      (_) {
        if (state is TaskLoaded) {
          final tasks = (state as TaskLoaded).tasks;
          final updatedTasks =
              tasks.where((task) => task.id != taskId).toList();
          emit(TaskLoaded(updatedTasks));
        }
      },
    );
  }
}
