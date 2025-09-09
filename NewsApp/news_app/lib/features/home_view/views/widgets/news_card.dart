import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class NewsCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String subTitle;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 269.w,
      height: 324.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: 250.w,
                  height: 232.h,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 250.w,
                  height: 232.h,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 40),
                ),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
