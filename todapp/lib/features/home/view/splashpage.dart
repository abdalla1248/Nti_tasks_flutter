import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import 'HomePage.dart';
import 'startpage.dart';
import '../cubit/splash_cubit.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit()..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToHome) {
            AppNavigator.pushReplacement(context, HomePage(username: state.userData['name'] ?? ''));
          } else if (state is SplashNavigateToStart) {
            AppNavigator.pushReplacement(context, StartPage());
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.todo,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 44.h,
                ),
                Text(
                  'TODO',
                  style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
