import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onChanged;
  final VoidCallback? onCartTap;

  const CustomSearchBar({
    super.key,
    this.onChanged,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          /// 🔍 Search Box
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: TextField(
                onChanged: onChanged,
                style: TextStyle(fontSize: 14.sp),
                textAlignVertical: TextAlignVertical.center, // ✅ centers text
                decoration: InputDecoration(
                  isDense: true, // ✅ reduces default padding
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: 20.sp,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          /// 🛒 Cart Button
          GestureDetector(
            onTap: onCartTap,
            child: Container(
              width: 45.w,
              height: 45.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22.5.r),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.orange,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
