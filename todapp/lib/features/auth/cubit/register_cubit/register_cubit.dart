import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todapp/features/auth/data/repo/auth_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final formKey = GlobalKey<FormState>();

  XFile? image;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword));
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword = !obscureConfirmPassword;
    emit(ChangeConfirmPasswordVisibility(obscureConfirmPassword));
  }

  Future<void> register() async {
    {
      if (!formKey.currentState!.validate()) {
        return;
      }
      emit(RegisterLoading());
      AuthRepo repo = AuthRepo.instance;
      var response = await repo.register(
          phone: phoneController.text,
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          image: image);
      response.fold((String error) => emit(RegisterFailure(error)),
          (userModel) => emit(RegisterSuccess()));
    }
  }
}
