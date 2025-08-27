import '../../tasks/data/model/task_model.dart';

class HomeState {
  final List<TaskModel> tasks;
  final String username;

  HomeState({this.tasks = const [], this.username = ""});

  HomeState copyWith({
    List<TaskModel>? tasks,
    String? username,
  }) {
    return HomeState(
      tasks: tasks ?? this.tasks,
      username: username ?? this.username,
    );
  }
}
