import 'package:flutter/material.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/app/home_booking_screen_controller.dart';
import 'package:trip_picker/utils/clipper/container_top_clipper.dart';
import 'package:trip_picker/utils/components/circle_avatar_image.dart';

tripPanel(
  HomeBookTripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  return
      // Obx(
      //   () {
      //     return
      Stack(
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
        margin: const EdgeInsets.only(top: 40), // Space for the avatar
        child: ClipPath(
          clipper: TripContainerAvatarClipper(),
          child: Container(
            color: colorScheme.surface,
            alignment: Alignment.center,
            child: Text(
              'Your Content Here',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
      // Positioned CircleAvatar
      Positioned(
        top: 0,
        child: circleAvatarImage(
          colorScheme,
          height: 95,
          foregroundImage: AssetImage(Assets.userAvatarPng),
        ),
      ),
    ],
  );
  //   },
  // );
}
