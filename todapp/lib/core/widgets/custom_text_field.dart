import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_assets.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? obscuringCharacter;
  final TextEditingController? controller;
  final String? errorText; // still usable for manual error messages
  final VoidCallback? onVisibilityToggle;
  final bool showVisibilityToggle;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.errorText,
    this.onVisibilityToggle,
    this.showVisibilityToggle = false,
    this.obscuringCharacter,
    this.onChanged,
    this.suffixIcon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter ?? '*',
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        prefixIcon: prefixIcon,
        errorText: errorText, // keep this if you want to support manual errors too
        suffixIcon: showVisibilityToggle
            ? IconButton(
                icon: (obscureText ? SvgPicture.asset(AppAssets.lock) : SvgPicture.asset(AppAssets.unlock)),
                onPressed: onVisibilityToggle,
              )
            : (suffixIcon),
      ),
    );
  }
}
