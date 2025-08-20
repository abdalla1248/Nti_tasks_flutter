import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import 'package:todapp/features/auth/data/repo/auth_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  static LoginCubit get(BuildContext context) => BlocProvider.of<LoginCubit>(context);

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword));
  }

  void login() async {
    emit(LoginLoading());
    try {
      final authRepo = AuthRepo();
      await authRepo.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
