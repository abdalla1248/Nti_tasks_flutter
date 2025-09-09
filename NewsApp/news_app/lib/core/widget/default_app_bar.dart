import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_paddings.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.secondary
      ),
      width: double.infinity.w,
      height: 130.h,
      child:
      Padding(
        padding: AppPaddings.defaultHomePadding,
        child: Column(
          children: [
            SizedBox(height: 40.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Good Morning,\nAhmed Salem",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary
                      ),
                    ),
                    Text(
                      "Sun 9 April, 2023",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          color: AppColors.textPrimary
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(AppAssets.weatherImage),
                    SizedBox(width: 4.w,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sunny 32",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.sp,
                              color: AppColors.textPrimary
                          ),
                        ),
                        Text(
                          "oC",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14.sp,
                              color: AppColors.textPrimary
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
