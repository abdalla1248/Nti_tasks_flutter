import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todapp/features/auth/data/repo/auth_repo.dart';

abstract class SplashState {}
class SplashInitial extends SplashState {}
class SplashNavigateToHome extends SplashState {
  final Map<String, dynamic> userData;
  SplashNavigateToHome(this.userData);
}
class SplashNavigateToStart extends SplashState {}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash({int seconds = 2}) async {
    await Future.delayed(Duration(seconds: seconds));
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Fetch user data from Firestore
      final userData = await AuthRepo.instance.getUser(user.uid);
      if (userData != null) {
        emit(SplashNavigateToHome(userData));
        return;
      }
    }
    emit(SplashNavigateToStart());
  }
}
