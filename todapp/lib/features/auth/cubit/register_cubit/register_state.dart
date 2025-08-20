abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}
class ChangeConfirmPasswordVisibility extends RegisterState {
  final bool obscureConfirmPassword;

  ChangeConfirmPasswordVisibility(this.obscureConfirmPassword);
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}
class ChangePasswordVisibility extends RegisterState {
  final bool obscurePassword;

  ChangePasswordVisibility(this.obscurePassword);
}
