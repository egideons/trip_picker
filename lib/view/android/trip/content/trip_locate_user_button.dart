import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';

tripLocateUserButton(
  ColorScheme colorScheme,
  TripScreenController controller,
  Size size,
) {
  return Positioned(
    bottom:
        controller.panelIsOpen.value ? size.height * .74 : size.height * .28,
    right: 10,
    child: IconButton(
      onPressed: controller.showDriverRatingDialog,
      style: IconButton.styleFrom(
        elevation: 20,
        padding: const EdgeInsets.all(0),
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Color(0xc0000000),
      ),
      icon: Image.asset(
        Assets.myLocationIconPng,
        height: 40,
        width: 40,
      ),
    ),
  ).animate().fade(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
}
