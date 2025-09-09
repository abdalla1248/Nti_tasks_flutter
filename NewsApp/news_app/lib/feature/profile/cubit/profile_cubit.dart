import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileCubit extends Cubit<Map<String, dynamic>> {
  ProfileCubit() : super({});

  Future<void> fetchWeather(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit({
          'temp': data['main']['temp'],
          'condition': data['weather'][0]['description'],
        });
      } else {
        emit({'error': 'Failed to fetch weather data'});
      }
    } catch (e) {
      emit({'error': e.toString()});
    }
  }
}
