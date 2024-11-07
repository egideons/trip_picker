import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/view/android/home_book_trip/android_home_book_trip_screen.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

//============= Load BottomNavView =============\\
  loadHome() async {
    await Get.offAll(
      () => const AndroidHomeBookTripScreen(),
      routeName: "/home-book-trip",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }
}
