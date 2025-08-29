import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() 
      : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of<SettingsCubit>(context);

   String currentLang='EN';

  void changeLanguage(String languageCode) {
    currentLang = languageCode;
    emit(ChangeLanguage(currentLang));
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

class LogoutSuccess extends SettingsState {}

class LogoutFailure extends SettingsState {
  final String error;

  LogoutFailure(this.error);
}
