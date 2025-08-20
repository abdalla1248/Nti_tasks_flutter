import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';
import '../data/model/profile_model.dart';
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
}
