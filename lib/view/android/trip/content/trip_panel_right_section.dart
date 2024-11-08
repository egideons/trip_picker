import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/trip/content/stars_widget.dart';

rightSection(TripScreenController controller, ColorScheme colorScheme) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      IconButton(
        onPressed: () {},
        tooltip: "Message Driver",
        enableFeedback: true,
        style: IconButton.styleFrom(
          padding: const EdgeInsets.all(14),
          backgroundColor: kButtonAccentColor,
          foregroundColor: kLightBackgroundColor,
          elevation: 20,
          shadowColor: Color(0xc0000000),
        ),
        icon: Icon(
          Iconsax.message_25,
          color: kLightBackgroundColor,
        ),
      ),
      20.toHeight,
      starsWidget(colorScheme, 3),
      Text(
        "Cost of trip",
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: defaultTextStyle(
          color: kDefaultTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      Text(
        "N ${FormatToType.doubleFormattedText(4700)}",
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    ],
  );
}
