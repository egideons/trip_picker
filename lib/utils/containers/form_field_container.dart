import 'package:flutter/material.dart';

Widget formFieldContainer(
  ColorScheme colorScheme,
  Size size, {
  Widget? child,
  double? containerHeight,
  double? containerWidth,
  double? borderRadius,
  double? borderSideWidth,
  EdgeInsetsGeometry? padding,
  Color? color,
  Color? borderSideColor,
}) {
  return Container(
    width: containerWidth ?? size.width,
    height: containerHeight ?? size.height * 0.06,
    padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
    decoration: ShapeDecoration(
      color: color ?? colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        side: BorderSide(
          color: borderSideColor ?? colorScheme.primary,
          width: borderSideWidth ?? 0.2,
        ),
      ),
      shadows: [
        BoxShadow(
          color: const Color(0x0C000000),
          blurRadius: 12,
          offset: const Offset(0, 4),
          spreadRadius: 7,
        ),
      ],
    ),
    child: Center(
      child: child,
    ),
  );
}
