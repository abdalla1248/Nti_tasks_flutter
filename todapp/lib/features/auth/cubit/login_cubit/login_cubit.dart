import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  static LoginCubit get(context) => BlocProvider.of(context);

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(ChangePasswordVisibility(obscurePassword));
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    emit(LoginLoading());

    try {
      // Login with Firebase Auth
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      // Fetch username from Firestore
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      final username = doc['username'] ?? '';

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);

      emit(LoginSuccess(username: username));
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    if (username.isNotEmpty) {
      emit(LoginSuccess(username: username));
    }
  }
}
