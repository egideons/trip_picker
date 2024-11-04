import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/auth/success_screen_controller.dart';
import 'package:trip_picker/controllers/auth/verify_phone_otp_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/auth/verify_phone_otp/content/form_section.dart';

import '../../../../constants/consts.dart';

class AndroidVerifyPhoneOtpScreen extends GetView<VerifyPhoneOtpController> {
  const AndroidVerifyPhoneOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(VerifyPhoneOtpController());
    Get.put(SuccessScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              40.toHeight,
              Text(
                "Verify OTP",
                textAlign: TextAlign.center,
                style: defaultTextStyle(
                  color: colorScheme.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              40.toHeight,
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: "Enter the ",
                  style: defaultTextStyle(
                    color: kTextGreyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "4-digit ",
                      style: defaultTextStyle(
                        color: kTextAccentColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: "code sent to phone number",
                      style: defaultTextStyle(
                        color: kTextGreyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              20.toHeight,
              verifyPhoneOtpFormSection(colorScheme, size, context, controller),
            ],
          ),
        ),
      ),
    );
  }
}