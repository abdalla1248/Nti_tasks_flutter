abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ChangeLanguage extends SettingsState {
  final String languageCode;

  ChangeLanguage(this.languageCode);
}
