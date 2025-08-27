part of 'edit_task_cubit.dart';

abstract class EditTaskState {}

class EditTaskInitial extends EditTaskState {}

class EditTaskLoading extends EditTaskState {}

class EditTaskLoaded extends EditTaskState {
  final TaskModel task;
  EditTaskLoaded({required this.task});
}

class EditTaskSuccess extends EditTaskState {
  final TaskModel task;
  EditTaskSuccess({required this.task});
}

class EditTaskDeleted extends EditTaskState {}

class EditTaskError extends EditTaskState {
  final String message;
  EditTaskError(this.message);
}
