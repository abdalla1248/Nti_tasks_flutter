import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/helper/app_navigator.dart';
import 'package:news_app/core/utils/app_assets.dart';
import 'package:news_app/core/utils/app_colors.dart';
import 'package:news_app/core/utils/app_paddings.dart';

import 'location_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 538.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.gradientColor_1,
                  AppColors.gradientColor_2,
                ],
              ),
              image: DecorationImage(
                image: AssetImage(AppAssets.welcomeImage),
                alignment: Alignment.centerLeft,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32.r),
                ),
              ),
              child: Padding(
                padding: AppPaddings.defaultHomePadding,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24.h),
                    Text(
                      textAlign:TextAlign.center,
                      "Get The Latest News\n And Updates",
                      style: TextStyle(fontSize: 32.sp, color: AppColors.textPrimary),
                    ),
                    Text(
                      textAlign:TextAlign.center,
                      "From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.",
                      style: TextStyle(fontSize: 18.sp, color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 12.h,),
                    ElevatedButton(
                        onPressed: (){
                          AppNavigator.goTo(context, LocationView(),type: NavigatorType.pushReplacement);
                        },
                        style:ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimary
                        ) ,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [ 
                            Text(
                              "Explore",
                            style: TextStyle(
                              color: AppColors.primary
                            ),
                          ),
                            SizedBox(width: 4.w,),
                            Icon(Icons.arrow_forward,color: AppColors.primary,)
                      ]
                        ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
