import '../model/profile_model.dart';

class ProfileRepo {
  Future<ProfileModel> getProfile(String userId) async {
    // Simulate fetching profile data
    await Future.delayed(const Duration(seconds: 1));
    return ProfileModel(uid: userId, name: 'User', email: 'user@email.com', image: '');
  }
}
