import 'package:flutter_bloc/flutter_bloc.dart';
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
}
