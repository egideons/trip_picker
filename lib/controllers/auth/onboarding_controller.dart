import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/app/android/auth/login_signup/android_login_signup_screen.dart';
import 'package:trip_picker/main.dart';

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
  var isLoading = false.obs;
  var pageController = PageController().obs;
  var onboardContent = OnboardContent().obs;

  getStarted() async {
    shouldAnimate.value = true;
    await Future.delayed(const Duration(milliseconds: 1400), () {
      isLoading.value = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    shouldAnimate.value = false;
    isLoading.value = false;
    prefs.setBool("isOnboarded", true);
    await Get.offAll(
      () => const AndroidLoginSignupScreen(),
      routeName: "/login-signup",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Transition.downToUp,
    );
  }
}
