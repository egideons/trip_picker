import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_outlined_button.dart';
import 'package:trip_picker/utils/clipper/container_top_clipper.dart';
import 'package:trip_picker/utils/components/circle_avatar_image.dart';
import 'package:trip_picker/view/android/trip/content/trip_panel_left_section.dart';
import 'package:trip_picker/view/android/trip/content/trip_panel_right_section.dart';

tripPanelSection(
  TripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  if (controller.panelIsOpen.value) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      leftSection(controller, colorScheme),
                      rightSection(controller, colorScheme),
                    ],
                  ),
                  20.toHeight,
                  pickupSection(colorScheme, controller),
                  4.toHeight,
                  SizedBox(
                    height: .2,
                    width: size.width,
                    child: DottedBorder(
                      color: kGreyColor,
                      strokeWidth: 1,
                      dashPattern: [4, 2],
                      child: SizedBox(
                        height: 1,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  4.toHeight,
                  destinationSection(controller),
                  20.toHeight,
                  Text(
                    "Driver Bio",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  10.toHeight,
                  Text(
                    "Normal Driver bio and Normal Driver bio andNormal Driver bio andNormal Driver bio and",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: defaultTextStyle(
                      color: kTextGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                  20.toHeight,
                  Text(
                    "Photos",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: defaultTextStyle(
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  10.toHeight,
                  SizedBox(
                    height: 80,
                    width: size.width,
                    child: ListView.separated(
                      itemCount: controller.ridersImages.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => 10.toWidth,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          width: 80,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                controller.ridersImages[index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  20.toHeight,
                  controller.driverIsArriving.value
                      ? Center(
                          child: SizedBox(
                            width: size.width - 200,
                            child: AndroidOutlinedButton(
                              title: "Cancel Trip",
                              onPressed: controller.showCancelRideDialog,
                              borderColor: kGreyColor,
                              textColor: kDefaultTextColor,
                              borderWidth: 1,
                            ),
                          ),
                        )
                      : SizedBox(),
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
                  color: kDefaultTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
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
  } else {
    return SizedBox();
  }
}

destinationSection(TripScreenController controller) {
  return Row(
    children: [
      Icon(
        Iconsax.location5,
        color: kGreenIconColor,
      ),
      10.toWidth,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "To",
              style: defaultTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: kDefaultTextColor,
              ),
            ),
            Text(
              controller.destination.value,
              overflow: TextOverflow.ellipsis,
              style: defaultTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: kTextGreyColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

pickupSection(ColorScheme colorScheme, TripScreenController controller) {
  return Row(
    children: [
      Icon(
        Iconsax.location5,
        color: colorScheme.primary,
      ),
      10.toWidth,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "From",
              style: defaultTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: kDefaultTextColor,
              ),
            ),
            Text(
              controller.pickupLocation.value,
              overflow: TextOverflow.ellipsis,
              style: defaultTextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: kTextGreyColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
