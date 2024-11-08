import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

panelBannerSection(
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  return AnimatedContainer(
    duration: Duration(seconds: 1),
    curve: Curves.easeInOut,
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    decoration: ShapeDecoration(
      color: colorScheme.inversePrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    ),
    child: () {
      if (controller.panelBannerHasButton.value) {
        return bannerWithButton(colorScheme, controller);
      } else {
        return Center(
          child: Text(
            "What would you like to do today?",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: defaultTextStyle(
              color: kTextWhiteColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ).animate().fadeIn(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 800),
              ),
        );
      }
    }(),
  ).animate().fade(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
}

bannerWithButton(
  ColorScheme colorScheme,
  HomeScreenController controller,
) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Text(
          "Go on 10 trips and get 5gb data bonus",
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: defaultTextStyle(
            color: kTextWhiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
      InkWell(
        onTap: () {},
        child: Container(
          height: 20,
          width: 40,
          margin: const EdgeInsets.only(right: 10),
          decoration: ShapeDecoration(
            color: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Center(
            child: Text(
              "Claim",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: defaultTextStyle(
                color: colorScheme.inversePrimary,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
