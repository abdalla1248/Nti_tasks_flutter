import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../data/auth_repo.dart';
import 'signup_state.dart';


class SignupCubit extends Cubit<SignupState>
{
  SignupCubit(): super(SignupInitial());
  static SignupCubit get(context) => BlocProvider.of(context);

  XFile? image;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  void changePasswordVisibility()
  {
    passwordSecure = !passwordSecure;
    emit(SignupChangePasswordVisibility());
  }
  void changeConfirmPasswordVisibility()
  {
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(SignupChangeConfirmPasswordVisibility());
  }

  onSignupPressed()async
  {
    if(!formKey.currentState!.validate())
    {
      return;
    }
    emit(SignupLoading());
    AuthRepo repo = AuthRepo();
    var response = await repo.register(
        phone: phoneController.text,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      image: image
    );
    response.fold(
            (String error)=> emit(SignupError(error: error)),
            (userModel)=> emit(SignupSuccess())
    );
  }
}