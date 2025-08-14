import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final double borderRadius;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool isOutlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.borderRadius = 12,
    this.textStyle,
    this.padding,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final btnStyle = textStyle ?? AppTextStyles.button;
    final btnPadding = padding ?? EdgeInsets.symmetric(vertical: 14.h);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
    );
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: btnPadding,
          shape: shape,
          side: BorderSide(color: color ?? Colors.green, width: 2),
        ),
        child: Text(text, style: btnStyle.copyWith(color: color ?? Colors.green)),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.green,
        padding: btnPadding,
        shape: shape,
      ),
      child: Text(text, style: btnStyle),
    );
  }
}
