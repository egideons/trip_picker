import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/android/onboarding/content/onboard_content.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance {
    return Get.find<OnboardingController>();
  }

  var pageController = PageController().obs;
  var onboardContent = OnboardContent().obs;
}
