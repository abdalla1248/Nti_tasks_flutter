import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
  
import 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit() : super(StartInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkLogin() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.reload(); 
      final refreshedUser = _auth.currentUser;
      final username = refreshedUser?.displayName ?? "User";
      emit(StartNavigateToHome(username));
    } else {
      emit(StartNavigateToLogin());
    }
  }

  Future<void> setUsername(String name) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
      await user.reload(); 
      final refreshedUser = _auth.currentUser;
      final updatedName = refreshedUser?.displayName ?? "User";
      emit(StartNavigateToHome(updatedName));
    }
  }
}