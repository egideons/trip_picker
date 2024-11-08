import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';

driverRatingDialog(
  TripScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return GestureDetector(
    onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
    child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => false,
      child: Obx(() {
        return Dialog(
          elevation: 20,
          alignment: Alignment.center,
          insetAnimationCurve: Curves.easeIn,
          backgroundColor: kTransparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Enjoyed your trip?",
                  textAlign: TextAlign.center,
                  style: defaultTextStyle(
                    color: kDefaultTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                20.toHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (index) => IconButton(
                      onPressed: () {
                        controller.rateDriver(size, index);
                      },
                      color: kStarColor,
                      icon: index < controller.rating.value
                          ? Icon(Icons.star, size: 30, color: kStarColor)
                          : Icon(Icons.star, size: 26, color: kGreyColor),
                    ),
                  ),
                ),
                20.toHeight,
                AndroidElevatedButton(
                  title: "Rate Driver",
                  onPressed: () {},
                ),
              ],
            ),
          ).animate().scale(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 800),
              ),
        );
      }),
    ),
  );
}
