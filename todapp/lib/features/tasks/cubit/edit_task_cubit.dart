import 'package:flutter_bloc/flutter_bloc.dart';
import '../../tasks/data/model/task_model.dart';
import '../../tasks/data/repo/task_repo.dart';

part 'edit_task_state.dart';

class EditTaskCubit extends Cubit<EditTaskState> {
  final TaskRepo taskRepo;
  late TaskModel _task;

  EditTaskCubit(this.taskRepo) : super(EditTaskInitial());

  void init(TaskModel task) {
    _task = task;
    emit(EditTaskLoaded(task: _task));
  }

  void updateTitle(String title) {
    _task = _task.copyWith(title: title);
    emit(EditTaskLoaded(task: _task));
  }

  void updateDescription(String description) {
    _task = _task.copyWith(description: description);
    emit(EditTaskLoaded(task: _task));
  }

  void updateType(String type) {
    _task = _task.copyWith(type: type);
    emit(EditTaskLoaded(task: _task));
  }

  void markDone() {
    _task = _task.copyWith(isDone: true);
    emit(EditTaskLoaded(task: _task));
  }

  Future<void> saveTask() async {
    emit(EditTaskLoading());
    // Keep original userId to satisfy Firestore rules
    final updatedTask = _task.copyWith(userId: _task.userId);
    final result = await taskRepo.updateTask(updatedTask);
    result.fold(
      (err) => emit(EditTaskError(err)),
      (_) => emit(EditTaskSuccess(task: updatedTask)),
    );
  }

  Future<void> deleteTask() async {
    emit(EditTaskLoading());
    final result = await taskRepo.deleteTask(_task.id);
    result.fold(
      (err) => emit(EditTaskError(err)),
      (_) => emit(EditTaskDeleted()),
    );
  }
}
