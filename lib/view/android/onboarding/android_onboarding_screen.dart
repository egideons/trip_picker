import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/auth/onboarding_controller.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/view/android/onboarding/content/image_section.dart';
import 'package:trip_picker/view/android/onboarding/content/page_indicator.dart';
import 'package:trip_picker/view/android/onboarding/content/text_section.dart';

class AndroidOnboardingScreen extends GetView<OnboardingController> {
  const AndroidOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(OnboardingController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GetBuilder<OnboardingController>(
      init: OnboardingController(),
      builder: (controller) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Obx(
            () {
              return Scaffold(
                backgroundColor: controller.currentPage.value + 1 ==
                        controller.onboardContent.value.items.length
                    ? colorScheme.secondary
                    : colorScheme.surface,
                appBar: AppBar(toolbarHeight: 0),
                body: SafeArea(
                  child: Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: controller.setIsLastPage,
                        controller: controller.pageController.value,
                        itemCount: controller.onboardContent.value.items.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var onboardItem =
                              controller.onboardContent.value.items[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                imageSection(controller, onboardItem),
                                10.toHeight,
                                textSection(
                                  colorScheme,
                                  onboardItem,
                                  controller,
                                ),
                                40.toHeight,
                                controller.currentPage.value + 1 ==
                                        controller
                                            .onboardContent.value.items.length
                                    ? SizedBox(
                                        width: size.width - 100,
                                        child: AndroidElevatedButton(
                                          title: "Get Started",
                                          onPressed: controller.getStarted,
                                          textColor: colorScheme.secondary,
                                          buttonColor: colorScheme.surface,
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          );
                        },
                      ),
                      controller.isLoading.value
                          ? BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 70,
                                sigmaY: 70,
                              ),
                              child: Center(
                                child: CircularProgressIndicator.adaptive(
                                  strokeAlign: 10,
                                  strokeWidth: 10,
                                  backgroundColor: colorScheme.surface,
                                ),
                              ),
                            )
                          : SizedBox(),
                      controller.isLoading.value
                          ? SizedBox()
                          : Positioned(
                              bottom: 120,
                              left: (size.width - 90) / 2,
                              child: pageIndicator(controller, colorScheme),
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
