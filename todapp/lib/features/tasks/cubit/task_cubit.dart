import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/task_model.dart';
import '../data/repo/task_repo.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final TaskRepo taskRepo;
  TaskCubit(this.taskRepo) : super(TaskLoading());

  void loadTasks(String userId) {
    emit(TaskLoading());
    taskRepo.getTasks(userId).listen(
      (tasks) => emit(TaskLoaded(tasks)),
      onError: (e) => emit(TaskError(e.toString())),
    );
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await taskRepo.addTask(task);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      await taskRepo.updateTask(task);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await taskRepo.deleteTask(id);
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }
}
