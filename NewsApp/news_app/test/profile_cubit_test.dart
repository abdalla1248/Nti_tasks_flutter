import 'package:flutter_test/flutter_test.dart';
import '../lib/feature/profile/cubit/profile_cubit.dart';

void main() {
  group('ProfileCubit', () {
    late ProfileCubit cubit;

    setUp(() {
      cubit = ProfileCubit();
    });

    test('Fetch weather data successfully', () async {
      await cubit.fetchWeather('Cairo');
      expect(cubit.state['temp'], 27);
      expect(cubit.state['condition'], 'Clear Sky');
    });

    test('Handle error during fetch', () async {
      await cubit.fetchWeather('InvalidCity');
      expect(cubit.state['error'], isNotNull);
    });
  });
}
