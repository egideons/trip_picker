import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

tripHeader(
    TripScreenController controller, Size size, ColorScheme colorScheme) {
  return AnimatedContainer(
    width: size.width,
    duration: Duration(milliseconds: 800),
    curve: Curves.ease,
    padding: EdgeInsets.all(10),
    decoration: ShapeDecoration(
      color: colorScheme.primary,
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
      controller.tripHeaderMsg.value,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: defaultTextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: kTextWhiteColor,
      ),
    ).animate().fadeIn(
          curve: Curves.easeIn,
          duration: Duration(milliseconds: 800),
        ),
  );
}
