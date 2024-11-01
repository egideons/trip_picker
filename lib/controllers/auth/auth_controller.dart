import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/app/android/onboarding/android_onboarding_screen.dart';

import '../../../main.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static AuthController get instance {
    return Get.find<AuthController>();
  }

  var isLoading = false.obs;

  var responseStatus = 0.obs;
  var responseMessage = "".obs;

  @override
  void onInit() {
    Timer(const Duration(days: 3), () {
      loadApp();
    });
    super.onInit();
  }

  var userEmail = prefs.getString("userEmail");
  var userPhoneNumber = prefs.getString("phoneNumber");
  var userPassword = prefs.getString("password");

  Future<void> loadApp() async {
    // bool isOnboarded = prefs.getBool("isOnboarded") ?? false;
    // bool hasNotBeenVerifiedOnSignup =
    //     prefs.getBool("hasNotBeenVerifiedEmailOnSignup") ?? false;
    // bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    // bool isLoggedOut = prefs.getBool("isLoggedOut") ?? false;

    if (Platform.isIOS) {
    } else {
      // if (isLoggedIn) {
      //   await UserController.instance.getUserProfile();
      //   await Get.offAll(
      //     () => const AndroidBottomNavigationView(),
      //     routeName: "/bottom-navigation-view",
      //     fullscreenDialog: true,
      //     curve: Curves.easeInOut,
      //     predicate: (routes) => false,
      //     popGesture: false,
      //     transition: Get.defaultTransition,
      //   );
      // } else if (!isLoggedIn && isLoggedOut) {
      //   await Get.offAll(
      //     () => const AndroidLoginScreen(),
      //     routeName: "/login",
      //     fullscreenDialog: true,
      //     curve: Curves.easeInOut,
      //     predicate: (routes) => false,
      //     popGesture: false,
      //     transition: Get.defaultTransition,
      //   );
      // } else if (isOnboarded) {
      //   await Get.offAll(
      //     () => const AndroidSignupScreen(),
      //     routeName: "/signup",
      //     fullscreenDialog: true,
      //     curve: Curves.easeInOut,
      //     predicate: (routes) => false,
      //     popGesture: false,
      //     transition: Get.defaultTransition,
      //   );
      // } else {
      await Get.offAll(
        () => const AndroidOnboardingScreen(),
        routeName: "/onboarding",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
    }
    // }
  }
}
