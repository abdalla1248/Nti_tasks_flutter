import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/features/auth/data/repo/auth_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  static RegisterCubit get(BuildContext context) =>
      BlocProvider.of<RegisterCubit>(context);

  // Toggle main password visibility
  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword));
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(ChangeConfirmPasswordVisibility(obscureConfirmPassword));
  }

  // Fake registration logic
  void register() async {
    AuthRepo authRepo = AuthRepo();
    if (formKey.currentState!.validate()) {
      emit(RegisterLoading());
      try {
        await authRepo.register(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
        );
        emit(RegisterSuccess());
      } catch (error) {
        emit(RegisterFailure(error.toString()));
      }
    }
  }
}
