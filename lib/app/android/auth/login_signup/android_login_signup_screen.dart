import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/login_signup_controller.dart';
import 'package:trip_picker/theme/colors.dart';

class AndroidLoginSignupScreen extends GetView<LoginSignupController> {
  const AndroidLoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(LoginSignupController());

    var colorScheme = Theme.of(context).colorScheme;
    // var size = MediaQuery.sizeOf(context);

    return GetBuilder<LoginSignupController>(
      init: LoginSignupController(),
      builder: (controller) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset(Assets.loginSignupBackgrounSvg),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
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
                                  height: 40,
                                  width: 40,
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
                                        "Login",
                                        style: defaultTextStyle(
                                          fontSize: 18,
                                          color: kTextHeaderColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Obx(() {
                                        return controller.isLoginPage.value
                                            ? AnimatedContainer(
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                height: 4,
                                                width: 44,
                                                decoration: ShapeDecoration(
                                                  color: colorScheme.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
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
                                        ),
                                      ),
                                      Obx(() {
                                        return !controller.isLoginPage.value
                                            ? AnimatedContainer(
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                height: 4,
                                                width: 44,
                                                decoration: ShapeDecoration(
                                                  color: colorScheme.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
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
                      ),
                      40.toHeight,
                      Expanded(
                        child: ListView(
                          children: [],
                        ),
                      )
                    ],
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
