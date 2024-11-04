import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/verfy_email_otp_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/utils/text_form_fields/android/android_textformfield.dart';

verifyEmailOtpFormSection(
  ColorScheme colorScheme,
  Size size,
  BuildContext context,
  VerifyEmailOtpController controller,
) {
  return Form(
    key: controller.formKey,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: formFieldContainer(
                    colorScheme,
                    size,
                    containerHeight: size.height * .08,
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 4,
                      bottom: 4,
                    ),
                    borderSideColor: controller.pin1FieldIsActive.value
                        ? colorScheme.primary
                        : kTransparentColor,
                    borderSideWidth: 1,
                    child: AndroidTextFormField(
                      controller: controller.pin1EC,
                      focusNode: controller.pin1FN,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                      cursorHeight: 30,
                      style: defaultTextStyle(
                        fontSize: 32.0,
                        color: kDefaultTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (value) {
                        controller.pin1Onchanged(value, context);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                20.toWidth,
                Flexible(
                  child: formFieldContainer(
                    colorScheme,
                    size,
                    containerHeight: size.height * .08,
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 4,
                      bottom: 4,
                    ),
                    borderSideColor: controller.pin2FieldIsActive.value
                        ? colorScheme.primary
                        : kTransparentColor,
                    borderSideWidth: 1,
                    child: AndroidTextFormField(
                      controller: controller.pin2EC,
                      focusNode: controller.pin2FN,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                      cursorHeight: 30,
                      style: defaultTextStyle(
                        fontSize: 32.0,
                        color: kDefaultTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (value) {
                        controller.pin2Onchanged(value, context);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                20.toWidth,
                Flexible(
                  child: formFieldContainer(
                    colorScheme,
                    size,
                    containerHeight: size.height * .08,
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 4,
                      bottom: 4,
                    ),
                    borderSideColor: controller.pin3FieldIsActive.value
                        ? colorScheme.primary
                        : kTransparentColor,
                    borderSideWidth: 1,
                    child: AndroidTextFormField(
                      controller: controller.pin3EC,
                      focusNode: controller.pin3FN,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                      cursorHeight: 30,
                      style: defaultTextStyle(
                        fontSize: 32.0,
                        color: kDefaultTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (value) {
                        controller.pin3Onchanged(value, context);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                20.toWidth,
                Flexible(
                  child: formFieldContainer(
                    colorScheme,
                    size,
                    containerHeight: size.height * .08,
                    padding: const EdgeInsets.only(
                      left: 18,
                      top: 4,
                      bottom: 4,
                    ),
                    borderSideColor: controller.pin4FieldIsActive.value
                        ? colorScheme.primary
                        : kTransparentColor,
                    borderSideWidth: 1,
                    child: AndroidTextFormField(
                      controller: controller.pin4EC,
                      focusNode: controller.pin4FN,
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.number,
                      cursorHeight: 30,
                      style: defaultTextStyle(
                        fontSize: 32.0,
                        color: kDefaultTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                      onFieldSubmitted: controller.onSubmitted,
                      onChanged: (value) {
                        controller.pin4Onchanged(value, context);
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        return null;
                      },
                    ),
                  ),
                ),
                20.toWidth,
              ],
            );
          }),
        ),
        20.toHeight,
        Obx(() {
          return Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: controller.timerComplete.value
                  ? ""
                  : "${controller.formatTime(controller.secondsRemaining.value)} ",
              style: defaultTextStyle(
                color: kTextGreyColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: " Resend",
                  mouseCursor: SystemMouseCursors.click,
                  recognizer: TapGestureRecognizer()
                    ..onTap = controller.timerComplete.value ||
                            controller.isLoading.value
                        ? controller.requestOTP
                        : null,
                  style: defaultTextStyle(
                    color: controller.timerComplete.value
                        ? colorScheme.primary
                        : kTextAccentColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }),
        60.toHeight,
        SizedBox(
          width: size.width - 80,
          child: Obx(() {
            return AndroidElevatedButton(
              title: "Verify",
              onPressed: controller.submitOTP,
              isLoading: controller.isLoading.value,
              minimumSize: Size(size.width, 50),
              borderRadius: 14,
              buttonColor: colorScheme.primary,
            );
          }),
        ),
      ],
    ),
  );
}
