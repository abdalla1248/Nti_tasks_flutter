import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() 
      : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of<SettingsCubit>(context);

   String currentLang='EN';

  void changeLanguage(String languageCode) {
    currentLang = languageCode;
    emit(ChangeLanguage(currentLang));
  }
  
  Future<void> updateUsername(String newUsername) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(UpdateUsernameFailure('User not logged in'));
        return;
      }

      // Update username in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'username': newUsername});

      // Save updated username in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', newUsername);

      emit(UpdateUsernameSuccess(newUsername));
    } catch (e) {
      emit(UpdateUsernameFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }
}


abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ChangeLanguage extends SettingsState {
  final String languageCode;

  ChangeLanguage(this.languageCode);
}

class UpdateUsernameSuccess extends SettingsState {
  final String username;

  UpdateUsernameSuccess(this.username);
}

class UpdateUsernameFailure extends SettingsState {
  final String error;

  UpdateUsernameFailure(this.error);
}

class LogoutSuccess extends SettingsState {}

class LogoutFailure extends SettingsState {
  final String error;

  LogoutFailure(this.error);
}
