abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupChangePasswordVisibility extends SignupState {}
class SignupChangeConfirmPasswordVisibility extends SignupState {}

class SignupLoading extends SignupState {}
class SignupSuccess extends SignupState {}
class SignupError extends SignupState {
  String error;
  SignupError({required this.error});
}