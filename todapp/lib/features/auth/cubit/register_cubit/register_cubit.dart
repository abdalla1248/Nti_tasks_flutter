import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoading());

    try {
      // Firebase registration
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save username in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': nameController.text.trim(),
        'email': emailController.text.trim(),
      });

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Registration failed';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email is already registered';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak';
      }
      emit(RegisterFailure(errorMessage));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
