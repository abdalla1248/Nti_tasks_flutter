import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'changepass_state.dart';

class ChangepassCubit extends Cubit<ChangepassState> {
  ChangepassCubit() : super(ChangepassInitial());

  final formKey = GlobalKey<FormState>();
  final oldpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final conpasswordController = TextEditingController();

  static ChangepassCubit get(BuildContext context) =>
      BlocProvider.of<ChangepassCubit>(context);

  void changePassword(String? currentPassword) {
    if (formKey.currentState!.validate()) {
      if (oldpasswordController.text != currentPassword) {
        emit(ChangepassError("Wrong old password"));
      } else if (newpasswordController.text != conpasswordController.text) {
        emit(ChangepassError("Passwords do not match"));
      } else {
        emit(ChangepassLoading());
        Future.delayed(const Duration(seconds: 1), () {
          emit(ChangepassSuccess());
        });
      }
    }
  }
}
