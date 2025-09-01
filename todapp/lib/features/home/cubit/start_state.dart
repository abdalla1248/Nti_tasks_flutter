abstract class StartState {}

class StartInitial extends StartState {}

class StartNavigateToHome extends StartState {
  final String username;
  StartNavigateToHome(this.username);
}

class StartNavigateToLogin extends StartState {}