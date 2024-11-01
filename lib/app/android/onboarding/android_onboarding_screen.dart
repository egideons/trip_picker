import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trip_picker/controllers/auth/onboarding_controller.dart';

class AndroidOnboardingScreen extends GetView<OnboardingController> {
  const AndroidOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(OnboardingController());

    var colorScheme = Theme.of(context).colorScheme;

    return GetBuilder<OnboardingController>(
      init: OnboardingController(),
      builder: (controller) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            body: Stack(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController.value,
                    children: [],
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: SmoothPageIndicator(
                    controller: controller.pageController.value,
                    count: controller.onboardContent.value.items.length,
                    onDotClicked: (index) =>
                        controller.pageController.value.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                    effect: SwapEffect(
                      spacing: 0,
                      radius: 20.0,
                      dotWidth: 40.0,
                      dotHeight: 2.5,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.0,
                      type: SwapType.yRotation,
                      dotColor: colorScheme.secondary,
                      activeDotColor: colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
