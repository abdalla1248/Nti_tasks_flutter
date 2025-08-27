abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});
}
class ChangePasswordVisibility extends LoginState {
  final bool obscurePassword;
  ChangePasswordVisibility(this.obscurePassword);
}

// New: pass username after login
class LoginSuccess extends LoginState {
  final String username;
  LoginSuccess({required this.username});
}
