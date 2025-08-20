import '../model/home_model.dart';

class HomeRepo {
  Future<HomeModel> getHomeData() async {
    // Simulate fetching home data
    await Future.delayed(const Duration(seconds: 1));
    return HomeModel(welcomeMessage: 'Welcome!', userId: 'userId');
  }
}
