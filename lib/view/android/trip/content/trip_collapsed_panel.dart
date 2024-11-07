import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/clipper/container_top_clipper.dart';
import 'package:trip_picker/utils/components/circle_avatar_image.dart';

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        tooltip: "Call Driver",
                        enableFeedback: true,
                        style: IconButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          backgroundColor: colorScheme.primary,
                          foregroundColor: kLightBackgroundColor,
                          elevation: 20,
                        ),
                        icon: Icon(
                          Iconsax.call5,
                          color: kLightBackgroundColor,
                        ),
                      ),
                      10.toHeight,
                      Text(
                        "John Doe",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: defaultTextStyle(
                          color: kDefaultTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
}
