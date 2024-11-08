import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/view/android/home/android_home_screen.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

//============= Load BottomNavView =============\\
  loadHome() async {
    await Get.offAll(
      () => const AndroidHomeScreen(),
      routeName: "/home",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }
}
