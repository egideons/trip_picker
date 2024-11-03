import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/login_signup_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/utils/text_form_fields/android/android_textformfield.dart';

signupSection(
  ColorScheme colorScheme,
  Size size,
  LoginSignupController controller,
) {
  return <Widget>[
    Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: controller.signupFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              formFieldContainer(
                colorScheme,
                size,
                containerHeight: size.height * .1,
                containerWidth: size.width - 80,
                padding: const EdgeInsets.all(10),
                borderSideColor: controller.signupPhoneFieldActive.value
                    ? colorScheme.primary
                    : kTransparentColor,
                borderSideWidth: 1,
                child: AndroidTextFormField(
                  controller: controller.signupPhoneNumberEC,
                  focusNode: controller.signupPhoneNumberFN,
                  onChanged: controller.signupPhoneOnchanged,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.phone,
                  labelText: "Phone number",
                  prefixIcon: Icon(
                    Iconsax.call,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              20.toHeight,
              formFieldContainer(
                colorScheme,
                size,
                containerHeight: size.height * .1,
                containerWidth: size.width - 80,
                padding: const EdgeInsets.all(10),
                borderSideColor: controller.signupEmailFieldActive.value
                    ? colorScheme.primary
                    : kTransparentColor,
                borderSideWidth: 1,
                child: AndroidTextFormField(
                  controller: controller.signupEmailEC,
                  focusNode: controller.signupEmailFN,
                  onChanged: controller.signupEmailOnchanged,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  labelText: "Email",
                  prefixIcon: Icon(
                    Iconsax.sms,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              20.toHeight,
              formFieldContainer(
                colorScheme,
                size,
                containerHeight: size.height * .1,
                containerWidth: size.width - 80,
                padding: const EdgeInsets.all(10),
                borderSideColor: controller.signupOccupationFieldActive.value
                    ? colorScheme.primary
                    : kTransparentColor,
                borderSideWidth: 1,
                child: AndroidTextFormField(
                  controller: controller.signupOccupationEC,
                  focusNode: controller.signupOccupationFN,
                  onChanged: controller.signupOccupationOnchanged,
                  onFieldSubmitted: controller.signupOnSubmitted,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  labelText: "Occupation",
                  prefixIcon: Icon(
                    Iconsax.user,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              60.toHeight,
              Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  textAlign: TextAlign.start,
                  TextSpan(
                    text: "Already have an account? ",
                    style: defaultTextStyle(
                      color: kTextGreyColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        mouseCursor: SystemMouseCursors.click,
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.isLoadingSignup.value
                              ? null
                              : controller.selectLoginPage,
                        style: defaultTextStyle(
                          color: colorScheme.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.toHeight,
              SizedBox(
                width: size.width - 80,
                child: Obx(() {
                  return AndroidElevatedButton(
                    title: "Sign up",
                    onPressed: controller.signup,
                    isLoading: controller.isLoadingSignup.value,
                    minimumSize: Size(size.width, 50),
                    borderRadius: 14,
                    buttonColor: colorScheme.primary,
                  );
                }),
              ),
            ],
          ),
        ),
      );
    })
  ];
}
