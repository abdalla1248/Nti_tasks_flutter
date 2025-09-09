import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: SizedBox(
        
        child: Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: BlocBuilder<ProfileCubit, Map<String, dynamic>>(
            builder: (context, weatherData) {
              if (weatherData.isEmpty) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ProfileCubit>().fetchWeather('Cairo');
                    },
                    child: Text('Fetch Weather'),
                  ),
                );
              }
              if (weatherData.containsKey('error')) {
                return Center(
                  child: Text('Error: ${weatherData['error']}'),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('City: Cairo', style: TextStyle(fontSize: 24)),
                  Text('Temperature: ${weatherData['temp']}°C', style: TextStyle(fontSize: 18)),
                  Text('Condition: ${weatherData['condition']}', style: TextStyle(fontSize: 18)),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProfileCubit>().fetchWeather('Cairo');
                    },
                    child: Text('Refresh'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
