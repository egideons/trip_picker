import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/login_signup_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';

loginSection(
  ColorScheme colorScheme,
  Size size,
  LoginSignupController controller,
) {
  return <Widget>[
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Welcome back!",
        textAlign: TextAlign.start,
        style: defaultTextStyle(
          color: colorScheme.primary,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    60.toHeight,
    Align(
      alignment: Alignment.centerLeft,
      child: Text(
        "Enter your Phone Number",
        textAlign: TextAlign.start,
        style: defaultTextStyle(
          color: kDefaultTextColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    Text(
      "Please confirm your country code and enter your phone number",
      textAlign: TextAlign.start,
      maxLines: 10,
      style: defaultTextStyle(
        color: kTextGreyColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
    60.toHeight,
    Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          formFieldContainer(
            colorScheme,
            size,
            containerHeight: size.height * .1,
            containerWidth: size.width - 80,
            color: colorScheme.surface,
            padding: const EdgeInsets.all(10),
            borderSideColor: controller.loginPhoneFieldActive.value
                ? colorScheme.primary
                : kTransparentColor,
            borderSideWidth: 1,
            child: IntlPhoneField(
              initialCountryCode: 'NG',
              controller: controller.loginPhoneNumberEC,
              disableLengthCheck: true,
              focusNode: controller.loginPhoneNumberFN,
              onChanged: controller.loginPhoneOnchanged,
              textInputAction: TextInputAction.done,
              onCountryChanged: controller.loginOnCountryChanged,
              onSubmitted: controller.loginOnSubmitted,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              pickerDialogStyle: PickerDialogStyle(
                backgroundColor: colorScheme.surface,
                countryNameStyle: defaultTextStyle(
                  fontSize: 14,
                  color: kFormFieldLabelTextColor,
                  fontWeight: FontWeight.w500,
                ),
                countryCodeStyle: defaultTextStyle(
                  fontSize: 14,
                  color: kFormFieldTextColor,
                  fontWeight: FontWeight.w700,
                ),
                listTileDivider: Divider(color: kGreyColor),
                searchFieldInputDecoration: InputDecoration(
                  labelText: "Search country",
                  labelStyle: defaultTextStyle(
                    fontSize: 20,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              dropdownIcon: Icon(
                Icons.keyboard_arrow_down,
                color: kGreyColor,
              ),
              showCountryFlag: false,
              decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: defaultTextStyle(
                  fontSize: 14,
                  color: kFormFieldLabelTextColor,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          20.toHeight,
          SizedBox(
            width: size.width - 80,
            child: Obx(() {
              return AndroidElevatedButton(
                title: "Continue",
                onPressed: controller.login,
                isLoading: controller.isLoadingLogin.value,
                minimumSize: Size(size.width, 50),
                borderRadius: 14,
                buttonColor: colorScheme.primary,
              );
            }),
          ),
        ],
      ),
    ),
  ];
}
