import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool passwordSecure = true;

  final AuthRepo repo = AuthRepo();

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(ChangePasswordVisibilityState());
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    final loginResponse = await repo.login(
      email: usernameController.text,
      password: passwordController.text,
    );

    loginResponse.fold(
      (String error) => emit(LoginError(error: error)),
      (userModel) => emit(LoginSuccess(userModel: userModel)),
    );
  }
}
