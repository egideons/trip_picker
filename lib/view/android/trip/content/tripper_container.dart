import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

tripperContainer(
  ColorScheme colorScheme,
  TripScreenController controller,
  Size size,
) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    width: size.width / 3.6,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: ShapeDecoration(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadows: [
        BoxShadow(
          color: const Color(0xc0000000),
          blurRadius: 8,
          offset: const Offset(0, 2),
          spreadRadius: -2,
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: kDarkBackgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xc0000000),
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: -2,
              ),
            ],
          ),
          child: Image.asset(
            Assets.tripperIconPng,
            height: 40,
            width: 40,
          ),
        ),
        4.toWidth,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedFlipCounter(
                value: controller.miningCredits.value,
                fractionDigits: 6,
                curve: Curves.easeInOut,
                textStyle: defaultTextStyle(
                  color: kTextGoldColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              AnimatedFlipCounter(
                value: controller.milesMined.value,
                fractionDigits: 2,
                suffix: " miles mined",
                curve: Curves.easeInOut,
                textStyle: defaultTextStyle(
                  color: kDefaultTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 8,
                ),
              ),
              // Text(
              //   "${FormatToType.doubleFormattedTextWithDecimal(0.2)} miles mined",
              //   textAlign: TextAlign.start,
              //   overflow: TextOverflow.ellipsis,
              //   maxLines: 1,
              //   style: defaultTextStyle(
              //     color: kDefaultTextColor,
              //     fontWeight: FontWeight.w600,
              //     fontSize: 8,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    ).animate().fade(
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        ),
  );
}
