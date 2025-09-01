import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/features/profile/data/model/profile_model.dart';
import 'profile_state.dart';
import '../data/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  void loadProfile(String userId) async {
    emit(ProfileLoading());
    try {
      final profile = await profileRepo.getProfile(userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUsername(String userId, String newUsername) async {
    try {
      emit(ProfileLoading());

      // Update in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'username': newUsername});

      // Reload updated profile
      final profile = await profileRepo.getProfile(userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
