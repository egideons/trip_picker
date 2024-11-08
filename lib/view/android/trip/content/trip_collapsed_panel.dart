import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/clipper/container_top_clipper.dart';
import 'package:trip_picker/utils/components/circle_avatar_image.dart';
import 'package:trip_picker/view/android/trip/content/trip_panel_left_section.dart';
import 'package:trip_picker/view/android/trip/content/trip_panel_right_section.dart';

tripCollapsedPanel(
  TripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.topCenter,
    children: [
      // The container with a circular cutout at the top
      Container(
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
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leftSection(controller, colorScheme),
                rightSection(controller, colorScheme),
              ],
            ),
          ),
        ),
      ),
      // Positioned CircleAvatar
      Positioned(
        top: 0,
        child: circleAvatarImage(
          colorScheme,
          height: 100,
          foregroundImage: AssetImage(Assets.userAvatarPng),
        ),
      ),
      Positioned(
        top: 116,
        child: SizedBox(
          width: size.width - 180,
          child: Center(
            child: Text(
              controller.tripPanelMsg.value,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: defaultTextStyle(
                color: controller.tripEnded.value
                    ? kTextRedColor
                    : colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ).animate().fade(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 800),
                ),
          ),
        ),
      ),
    ],
  );
}
