import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/app/book_trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/clipper/container_top_clipper.dart';
import 'package:trip_picker/utils/components/circle_avatar_image.dart';

import '../../../../constants/consts.dart';

driverFoundModal(
  BookTripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  return Obx(() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // The container with a circular cutout at the top
        Container(
          width: size.width,
          decoration: ShapeDecoration(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          margin: const EdgeInsets.only(top: 50), // Space for the avatar
          child: ClipPath(
            clipper: TripContainerAvatarClipper(),
            child: Container(
              color: colorScheme.surface,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    60.toHeight,
                    Text(
                      "Driver found",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    10.toHeight,
                    Text(
                      "Arriving in 6 minutes",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: kTextGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    10.toHeight,
                    Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: kTrackColor),
                        ),
                      ),
                      child: LinearProgressIndicator(
                        value: controller.progress.value,
                        minHeight: 3,
                        borderRadius: BorderRadius.circular(30),
                        backgroundColor: kTrackColor,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(colorScheme.primary),
                      ),
                    ),
                    20.toHeight,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: circleAvatarImage(
            colorScheme,
            height: 95,
            foregroundImage: AssetImage(Assets.userAvatarPng),
          ),
        ),
      ],
    ).animate().fadeIn(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
  });
}
