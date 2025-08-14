import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/utils/app_assets.dart';

import '../../core/utils/app_colors.dart';
import 'startpage.dart';

class SplashCard extends StatefulWidget {
  const SplashCard({super.key});

  @override
  State<SplashCard> createState() => _SplashCardState();
}

class _SplashCardState extends State<SplashCard> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      AppNavigator.pushReplacement(context, const StartPage());
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
