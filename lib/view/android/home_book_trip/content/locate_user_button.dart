import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trip_picker/constants/assets.dart';

locateUserButton(ColorScheme colorScheme) {
  return Positioned(
    bottom: 160,
    right: 20,
    child: IconButton(
      onPressed: () {},
      style: IconButton.styleFrom(
        elevation: 20,
        padding: const EdgeInsets.all(0),
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
