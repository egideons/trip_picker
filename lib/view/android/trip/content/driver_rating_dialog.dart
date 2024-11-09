import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/utils/text_form_fields/android/android_textformfield.dart';

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
      child: Obx(
        () {
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.hasRated.value)
                      if (controller.rating.value <= 2) ...[
                        Text(
                          "What didn't you like?",
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        40.toHeight,
                        badRatingReasons(controller, colorScheme),
                        20.toHeight,
                        if (controller
                            .badRatingFeedbackTextFieldIsVisible.value)
                          badRatingTextField(controller, colorScheme, size),
                        20.toHeight,
                      ] else ...[
                        Text(
                          "What did you enjoy about the ride?",
                          textAlign: TextAlign.center,
                          style: defaultTextStyle(
                            color: kTextBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        40.toHeight,
                        goodRatingReasons(controller, colorScheme),
                        20.toHeight,
                      ]
                    else
                      Text(
                        "Enjoyed your trip?",
                        textAlign: TextAlign.center,
                        style: defaultTextStyle(
                          color: kTextBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    starsRatingSection(controller),
                    controller.rating.value <= 2
                        ? AndroidElevatedButton(
                            title: "Rate Driver",
                            disable:
                                controller.badRateDriverButtonIsDisabled.value,
                            onPressed: controller.submitBadRating,
                          )
                        : AndroidElevatedButton(
                            title: "Rate Driver",
                            disable:
                                controller.goodRateDriverButtonIsDisabled.value,
                            onPressed: controller.submitGoodRating,
                          ),
                  ],
                ),
              ),
            ),
          ).animate().scale(
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 800),
              );
        },
      ),
    ),
  );
}

badRatingTextField(
  TripScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return Form(
    key: controller.badRatingFormKey,
    child: formFieldContainer(
      colorScheme,
      size,
      containerHeight: size.height * .2,
      borderSideWidth:
          controller.badRatingFeedbackTextFieldIsActive.value ? 1.6 : 0,
      child: Align(
        alignment: Alignment.topLeft,
        child: AndroidTextFormField(
          controller: controller.badRatingFeedbackEC,
          textInputAction: TextInputAction.newline,
          focusNode: controller.badRatingFeedbackFN,
          textCapitalization: TextCapitalization.sentences,
          onChanged: controller.badRatingOnChanged,
          keyboardType: TextInputType.multiline,
          maxLines: 1000,
          hintText: "Enter reason here",
          validator: (value) {
            return null;
          },
        ),
      ),
    ),
  );
}

starsRatingSection(TripScreenController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      5,
      (index) => IconButton(
        onPressed: () {
          controller.rateDriver(index);
        },
        color: kStarColor,
        icon: index < controller.rating.value
            ? Icon(Icons.star, size: 36, color: kStarColor)
            : Icon(Icons.star, size: 30, color: kLightGreyColor),
      ),
    ),
  ).animate().fade(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 800),
      );
}

goodRatingReasons(
  TripScreenController controller,
  ColorScheme colorScheme,
) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    alignment: WrapAlignment.center,
    children: List.generate(
      controller.goodReasons.length,
      (index) {
        var reason = controller.goodReasons[index];
        var reasonIsSelected = controller.goodReasonIsSelected[index];
        return InkWell(
          onTap: () {
            controller.toggleGoodReasonSelection(index);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: ShapeDecoration(
              color: reasonIsSelected ? colorScheme.primary : kTransparentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  width: 1,
                  color: colorScheme.primary,
                ),
              ),
            ),
            child: Text(
              reason,
              textAlign: TextAlign.center,
              style: defaultTextStyle(
                color: reasonIsSelected ? kTextWhiteColor : kTextBlackColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    ),
  ).animate().fade(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 800),
      );
}

badRatingReasons(
  TripScreenController controller,
  ColorScheme colorScheme,
) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    alignment: WrapAlignment.center,
    children: List.generate(
      controller.badReasons.length,
      (index) {
        var reason = controller.badReasons[index];
        var reasonIsSelected = controller.badReasonIsSelected[index];
        return InkWell(
          onTap: () {
            controller.toggleBadReasonSelection(index);
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: ShapeDecoration(
              color: reasonIsSelected ? colorScheme.primary : kTransparentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  width: 1,
                  color: colorScheme.primary,
                ),
              ),
            ),
            child: Text(
              reason,
              textAlign: TextAlign.center,
              style: defaultTextStyle(
                color: reasonIsSelected ? kTextWhiteColor : kTextBlackColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    ),
  ).animate().fade(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 800),
      );
}
