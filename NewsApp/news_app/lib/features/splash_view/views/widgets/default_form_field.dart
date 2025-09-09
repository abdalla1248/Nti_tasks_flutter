import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class DefaultFormField extends StatefulWidget {
  const DefaultFormField({
    super.key,
    this.validator,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    // this.suffixIcon,
    // this.obscureText = false,
    // this.readOnly = false,
    // this.onTap,
  });

  final String? Function(String?)? validator;
  // final VoidCallback? onTap;
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  // final Widget? suffixIcon;
  // final bool obscureText;
  // final bool readOnly;

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  InputBorder borderBuilder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: AppColors.lightGrey),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      child: TextFormField(
        // minLines: 1,
        // maxLines: null,
        // keyboardType: TextInputType.multiline,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary),
          fillColor: AppColors.lightGrey,
          filled: true,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          border: borderBuilder(),
          focusedBorder: borderBuilder(),
          enabledBorder: borderBuilder(),
        ),
      ),
    );
  }
}
