import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todapp/core/utils/app_assets.dart';

class CustomAuthImage extends StatelessWidget {
  const CustomAuthImage({super.key, this.image = const AssetImage(AppAssets.flag)});

  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 298.h,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: image,
              fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r)
          )
      ),
    );
  }
}