import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/android/onboarding/content/onboard_content.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance {
    return Get.find<OnboardingController>();
  }

  @override
  void onInit() {
    pageController.value.addListener(pageListener);

    super.onInit();
  }

  pageListener() {
    currentPage.value = pageController.value.page!.round();
  }

  setIsLastPage(index) {
    isLastPage.value = onboardContent.value.items.length - 1 == index;
  }

  var currentPage = 0.obs;
  var isLastPage = false.obs;
  var shouldAnimate = false.obs;
  var pageController = PageController().obs;
  var onboardContent = OnboardContent().obs;

  void triggerGetStartedAnimation() {
    shouldAnimate.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      shouldAnimate.value = false;
    });
  }

  getStarted() {
    triggerGetStartedAnimation();
  }
}
