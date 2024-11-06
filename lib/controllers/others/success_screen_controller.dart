import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/view/android/home_book_trip/android_home_book_trip_screen.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

//============= Variables =============\\
  var isLoading = false.obs;

//============= Load BottomNavView =============\\
  loadHome() async {
    isLoading.value = true;

    // await UserController.instance.getUserProfile();
    await Future.delayed(const Duration(seconds: 2));

    await Get.offAll(
      () => const AndroidHomeBookTripScreen(),
      routeName: "/home-book-trip",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );

    isLoading.value = true;
  }
}
