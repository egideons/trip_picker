import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

leftSection(
  TripScreenController controller,
  ColorScheme colorScheme,
) {
  return Column(
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
          shadowColor: Color(0xc0000000),
        ),
        icon: Icon(
          Iconsax.call5,
          color: kLightBackgroundColor,
        ),
      ),
      20.toHeight,
      Text(
        "John Doe",
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      Text(
        "Toyota Corolla, Black",
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: defaultTextStyle(
          color: kDefaultTextColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      Text(
        "BEN234AU",
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    ],
  );
}
