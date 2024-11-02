import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trip_picker/controllers/auth/onboarding_controller.dart';
import 'package:trip_picker/theme/colors.dart';

pageIndicator(OnboardingController controller, ColorScheme colorScheme) {
  return SmoothPageIndicator(
    controller: controller.pageController.value,
    count: controller.onboardContent.value.items.length,
    onDotClicked: (index) => controller.pageController.value.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    ),
    effect: CustomizableEffect(
      activeDotDecoration: DotDecoration(
        width: 10,
        height: 10,
        color: controller.currentPage.value + 1 ==
                controller.onboardContent.value.items.length
            ? colorScheme.surface
            : colorScheme.secondary,
        borderRadius: BorderRadius.circular(24),
      ),
      dotDecoration: DotDecoration(
        width: 6,
        height: 6,
        color: controller.currentPage.value + 1 ==
                controller.onboardContent.value.items.length
            ? kTransparentColor
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        dotBorder: DotBorder(
          padding: 2,
          width: 1,
          color: controller.currentPage.value + 1 ==
                  controller.onboardContent.value.items.length
              ? colorScheme.surface
              : colorScheme.secondary,
        ),
      ),
      spacing: 10.0,
    ),
  );
}
