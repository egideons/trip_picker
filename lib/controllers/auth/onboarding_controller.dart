import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/main.dart';
import 'package:trip_picker/view/android/auth/login_signup/android_login_signup_screen.dart';

import '../../view/android/onboarding/content/onboard_content.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance {
    return Get.find<OnboardingController>();
  }

  @override
  void onInit() {
    pageController.value.addListener(pageListener);
    startAutoPageTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _pageTimer?.cancel(); // Clear timer on controller close
    super.onClose();
  }

  //=============== Variables ==============\\
  Timer? _pageTimer;
  var currentPage = 0.obs;
  var onboardContent = OnboardContent().obs;

  //=============== Booleans ==============\\
  var isLastPage = false.obs;
  var shouldAnimate = false.obs;
  var isLoading = false.obs;

  //=============== Controllers ==============\\
  var pageController = PageController().obs;

  //=============== Functions ==============\\
  // Listener to track current page and reset the timer if user navigates manually
  pageListener() {
    int newPage = pageController.value.page!.round();
    if (newPage != currentPage.value) {
      currentPage.value = newPage;
      resetAutoPageTimer();
    }
    setIsLastPage(newPage);
  }

  // Checks if the current page is the last page
  setIsLastPage(int index) {
    isLastPage.value = onboardContent.value.items.length - 1 == index;
    if (isLastPage.value) {
      _pageTimer?.cancel(); // Stop timer if on the last page
    }
  }

  // Starts the auto page navigation timer
  void startAutoPageTimer() {
    _pageTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (!isLastPage.value) {
        goToNextPage();
      } else {
        timer.cancel();
      }
    });
  }

  // Reset and restart the timer
  void resetAutoPageTimer() {
    _pageTimer?.cancel();
    if (!isLastPage.value) {
      startAutoPageTimer();
    }
  }

  // Manually go to the next page
  goToNextPage() {
    if (currentPage.value < onboardContent.value.items.length - 1) {
      pageController.value.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

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
