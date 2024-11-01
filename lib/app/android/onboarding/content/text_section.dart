import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/onboarding_controller.dart';
import 'package:trip_picker/models/onboard_model.dart';
import 'package:trip_picker/theme/colors.dart';

textSection(
  ColorScheme colorScheme,
  OnboardModel onboardItem,
  OnboardingController controller,
) {
  if (controller.currentPage.value + 1 ==
      controller.onboardContent.value.items.length) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${onboardItem.title} ",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: defaultTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: colorScheme.surface,
          ),
        ),
        10.toHeight,
        Text(
          "${onboardItem.description} ",
          textAlign: TextAlign.center,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: defaultTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: kTextWhiteColor.withOpacity(.8),
          ),
        ),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BorderedText(
              strokeWidth: 1.4,
              strokeColor: colorScheme.inversePrimary,
              child: Text(
                "${onboardItem.title} ",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: defaultTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.secondary,
                ),
              ),
            ),
            BorderedText(
              strokeWidth: 1.4,
              strokeColor: colorScheme.inversePrimary,
              child: Text(
                "${onboardItem.otherTitle} ",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: defaultTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        controller.currentPage.value + 1 ==
                controller.onboardContent.value.items.length - 4
            ? BorderedText(
                strokeWidth: 1.4,
                strokeColor: colorScheme.inversePrimary,
                child: Text(
                  "${onboardItem.afterText} ",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: defaultTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colorScheme.secondary,
                  ),
                ),
              )
            : SizedBox(),
        10.toHeight,
        Text(
          "${onboardItem.description} ",
          textAlign: TextAlign.center,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: defaultTextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: kTextGreyColor,
          ),
        ),
      ],
    );
  }
}
