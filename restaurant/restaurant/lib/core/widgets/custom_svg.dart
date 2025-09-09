import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


/// Reusable SVG widget from `core/widgets` with optional sizing, color and tap.
class CustomSvg extends StatelessWidget {
  const CustomSvg({
    super.key,
    required this.path,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticsLabel,
    this.onTap,
  });

  final String path;
  final Color? color;
  final BoxFit fit;
  final String? semanticsLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final widget = SvgPicture.asset(
      path,
      fit: fit,
      semanticsLabel: semanticsLabel,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: widget);
    }
    return widget;
  }
}