import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/login_signup_controller.dart';
import 'package:trip_picker/theme/colors.dart';

loginSignupHeader(LoginSignupController controller, ColorScheme colorScheme) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 20,
      right: 20,
      top: 50,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              Assets.appIconSvg,
              height: 52,
              width: 52,
            ),
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: controller.selectLoginPage,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Text(
                    "Log in",
                    style: defaultTextStyle(
                      fontSize: 18,
                      color: kTextHeaderColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.2,
                    ),
                  ),
                  Obx(() {
                    return controller.isLoginPage.value
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            height: 4,
                            width: 44,
                            decoration: ShapeDecoration(
                              color: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  24,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(height: 4);
                  }),
                ],
              ),
            ),
            40.toWidth,
            InkWell(
              onTap: controller.selectSignupPage,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Text(
                    "Sign up",
                    style: defaultTextStyle(
                      fontSize: 18,
                      color: kTextHeaderColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.2,
                    ),
                  ),
                  Obx(() {
                    return !controller.isLoginPage.value
                        ? AnimatedContainer(
                            duration: Duration(milliseconds: 1000),
                            height: 4,
                            width: 44,
                            decoration: ShapeDecoration(
                              color: colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          )
                        : SizedBox(height: 4);
                  }),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
