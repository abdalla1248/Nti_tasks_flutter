import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/core/helpers/navigate.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_size.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';
import 'package:restaurant/core/widgets/app_button.dart';
import 'package:restaurant/feature/auth/view/signup_view.dart';

import 'login_view.dart';


class WelcomView extends StatelessWidget {
  const WelcomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.splashLogo,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                AppColors.yellow,
                BlendMode.srcIn,
              ),
            ),
            AppSize.s26,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'YUM',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.yellow),
                ),
                Text(
                  'QUICK',
                  style: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 48.w),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white),
              ),
            ),
            SizedBox(height: 43.h),
            AppButton(
                text: 'Log In',
                textStyle: AppTextStyles.title,
                color: AppColors.yellow,
                size: Size(207.w, 45.h),
                padding: EdgeInsets.only(top: 6.h, bottom: 9.h),
                onPressed: () =>AppNavigator.pushReplacement(context, LoginView())),
            AppButton(
                text: 'Sign Up',
                textStyle: AppTextStyles.title,
                color: AppColors.lightYellow,
                size: Size(207.w, 45.h),
                padding: EdgeInsets.only(top: 6.h, bottom: 9.h),
                onPressed: () =>AppNavigator.pushReplacement(context, SignupView())),
          ],
        ),
      ),
    );
  }
}
