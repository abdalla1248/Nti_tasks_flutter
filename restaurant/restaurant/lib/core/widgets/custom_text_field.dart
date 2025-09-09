import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_assets.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String obscuringCharacter;
  final TextEditingController? controller;
  final String? errorText;
  final VoidCallback? onVisibilityToggle;
  final bool showVisibilityToggle;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.controller,
    this.errorText,
    this.onVisibilityToggle,
    this.showVisibilityToggle = false,
    this.onChanged,
    this.maxLines = 1,
    this.validator,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.yellow.shade50,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.orange, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        prefixIcon: prefixIcon,
        errorText: errorText,
        suffixIcon: showVisibilityToggle
            ? IconButton(
                icon: obscureText
                    ? SvgPicture.asset(AppAssets.lock)
                    : SvgPicture.asset(AppAssets.unlock),
                onPressed: onVisibilityToggle,
              )
            : suffixIcon,
      ),
    );
  }
}
