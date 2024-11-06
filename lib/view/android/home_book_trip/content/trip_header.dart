import 'package:flutter/material.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/theme/colors.dart';

tripHeader(Size size, ColorScheme colorScheme) {
  return AnimatedContainer(
    width: size.width,
    duration: Duration(milliseconds: 800),
    curve: Curves.ease,
    padding: EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadows: [
        BoxShadow(
          color: const Color(0xc0000000),
          blurRadius: 4,
          offset: const Offset(0, 2),
          spreadRadius: -2,
        ),
      ],
    ),
    child: Text(
      "Arriving in 4 mins",
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: defaultTextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: kDefaultTextColor,
      ),
    ),
  );
}
