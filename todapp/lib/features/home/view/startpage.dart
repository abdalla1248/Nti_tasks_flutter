import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/utils/app_text_styles.dart';
import 'package:todapp/features/auth/view/Login.dart';
import 'package:todapp/features/home/view/HomePage.dart';

import '../cubit/start_cubit.dart';
import '../cubit/start_state.dart';
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StartCubit()..checkLogin(),
      child: BlocListener<StartCubit, StartState>(
        listener: (context, state) {
          if (state is StartNavigateToHome) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(username: state.username),
              ),
            );
          } else if (state is StartNavigateToLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Login()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.start, height: 400),
              const SizedBox(height: 20),
              Text(
                'Welcome To  \n Do It !',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 10),
              Text(
                'Ready to conquer your tasks? \nLet\'s Do It together.',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.green[600],
                  ),
                  child: Text("Let's Started", style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
