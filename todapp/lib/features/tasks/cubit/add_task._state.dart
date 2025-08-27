import '../../tasks/data/model/task_model.dart';

abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {
  final TaskModel task;
  AddTaskSuccess(this.task);
}

class AddTaskFailure extends AddTaskState {
  final String error;
  AddTaskFailure(this.error);
}
