abstract class ChangepassState {}

class ChangepassInitial extends ChangepassState {}

class ChangepassLoading extends ChangepassState {}

class ChangepassSuccess extends ChangepassState {}

class ChangepassError extends ChangepassState {
  final String message;

  ChangepassError(this.message);
}
