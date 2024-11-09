import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/buttons/android/android_outlined_button.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/utils/text_form_fields/android/android_textformfield.dart';

cancelRideDialog(
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
              height: size.height * .44,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: PageView.custom(
                controller: controller.cancelRideDialogPageController.value,
                physics: NeverScrollableScrollPhysics(),
                childrenDelegate: SliverChildListDelegate(
                  [
                    cancelRideDialogPage1(controller),
                    cancelRideDialogPage2(controller, colorScheme, size),
                    cancelRideDialogPage3(),
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

cancelRideDialogPage3() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      40.toHeight,
      Image.asset(Assets.doubleGreenTickIconPng),
      Text(
        "Trip Cancelled",
        textAlign: TextAlign.center,
        style: defaultTextStyle(
          color: kSuccessColor,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      40.toHeight,
    ],
  );
}

cancelRideDialogPage2(
  TripScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Text(
          "Why cancel the ride?",
          textAlign: TextAlign.center,
          style: defaultTextStyle(
            color: kTextBlackColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        40.toHeight,
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: List.generate(
            controller.cancelRideReasons.length,
            (index) {
              var reason = controller.cancelRideReasons[index];
              var reasonIsSelected =
                  controller.cancelRideReasonIsSelected[index];
              return InkWell(
                onTap: () {
                  controller.toggleCancelRideReasonsSelection(index);
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: ShapeDecoration(
                    color: reasonIsSelected
                        ? colorScheme.primary
                        : kTransparentColor,
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
                      color:
                          reasonIsSelected ? kTextWhiteColor : kTextBlackColor,
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
            ),
        20.toHeight,
        if (controller.cancelRideOtherOptionIsSelected.value)
          Form(
            key: controller.cancelRideFormKey,
            child: formFieldContainer(
              colorScheme,
              size,
              containerHeight: size.height * .2,
              borderSideWidth:
                  controller.cancelRideOtherOptionIsActive.value ? 1.6 : 0,
              child: Align(
                alignment: Alignment.topLeft,
                child: AndroidTextFormField(
                  controller: controller.cancelRideOtherOptionEC,
                  textInputAction: TextInputAction.newline,
                  focusNode: controller.cancelRideOtherOptionFN,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: controller.cancelRideOtherOptionOnChanged,
                  keyboardType: TextInputType.multiline,
                  maxLines: 1000,
                  maxLength: 250,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  hintText:
                      "Kindly state the reason for canceling this trip...",
                  hintStyle: defaultTextStyle(
                    fontSize: 12.0,
                    color: kFormFieldLabelTextColor,
                    fontWeight: FontWeight.normal,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
          ),
        40.toHeight,
        AndroidElevatedButton(
          title: "Submit",
          disable: !controller.cancelRideSubmitButtonIsEnabled.value,
          onPressed: controller.submitCancelRideForm,
        ),
      ],
    ),
  );
}

cancelRideDialogPage1(TripScreenController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "Cancel ride",
        textAlign: TextAlign.center,
        style: defaultTextStyle(
          color: kTextBlackColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      Text(
        "Are you sure you want to cancel the ride?",
        textAlign: TextAlign.center,
        style: defaultTextStyle(
          color: kDefaultTextColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      SvgPicture.asset(Assets.banIconSvg),
      20.toHeight,
      Row(
        children: [
          Expanded(
            child: AndroidElevatedButton(
              title: "Yes, Cancel",
              onPressed: controller.goToCancelRideDialogNextPage,
            ),
          ),
          10.toWidth,
          Expanded(
            child: AndroidOutlinedButton(
              title: "No, Go Back",
              borderColor: kDarkBackgroundColor,
              textColor: kDefaultTextColor,
              onPressed: controller.exitCancelRideDialog,
            ),
          ),
        ],
      ),
    ],
  );
}
