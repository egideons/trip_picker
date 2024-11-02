import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:phone_text_field/phone_text_field.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/login_signup_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/view/android/auth/login_signup/content/login_signup_header.dart';

class AndroidLoginSignupScreen extends GetView<LoginSignupController> {
  const AndroidLoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(LoginSignupController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GetBuilder<LoginSignupController>(
      init: LoginSignupController(),
      builder: (controller) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            body: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child:
                              SvgPicture.asset(Assets.loginSignupBackgrounSvg),
                        ),
                        Column(
                          children: [
                            loginSignupHeader(controller, colorScheme),
                            60.toHeight,
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Obx(() {
                                  return AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 800),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
                                      return SizeTransition(
                                        sizeFactor: animation,
                                        child: child,
                                      ).animate().scale();
                                    },
                                    child: Column(
                                      key: ValueKey(
                                          controller.isLoginPage.value),
                                      children: () {
                                        if (controller.isLoginPage.value) {
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
                                                  letterSpacing: -1.0,
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
                                                  letterSpacing: -1.0,
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
                                                letterSpacing: -1.0,
                                              ),
                                            ),
                                            60.toHeight,
                                            Form(
                                              key: controller.loginFormKey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  formFieldContainer(
                                                    colorScheme,
                                                    size,
                                                    containerHeight:
                                                        size.height * .08,
                                                    containerWidth:
                                                        size.width - 80,
                                                    color: colorScheme.surface,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    borderSideColor:
                                                        kTransparentColor,
                                                    borderSideWidth: 0,
                                                    child: PhoneTextField(
                                                      showCountryCodeAsIcon:
                                                          true,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ];
                                        } else {
                                          return <Widget>[];
                                        }
                                      }(),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
