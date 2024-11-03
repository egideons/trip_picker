import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/login_signup_controller.dart';
import 'package:trip_picker/view/android/auth/login_signup/content/login_section.dart';
import 'package:trip_picker/view/android/auth/login_signup/content/login_signup_header.dart';
import 'package:trip_picker/view/android/auth/login_signup/content/signup_section.dart';

class AndroidLoginSignupScreen extends GetView<LoginSignupController> {
  const AndroidLoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(LoginSignupController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

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
                      child: SvgPicture.asset(Assets.loginSignupBackgrounSvg),
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
                              return Column(
                                key: ValueKey(controller.isLoginPage.value),
                                children: () {
                                  if (controller.isLoginPage.value) {
                                    return loginSection(
                                      colorScheme,
                                      size,
                                      controller,
                                    );
                                  } else {
                                    return signupSection(
                                      colorScheme,
                                      size,
                                      controller,
                                    );
                                  }
                                }(),
                              ).animate().scale();
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
  }
}
