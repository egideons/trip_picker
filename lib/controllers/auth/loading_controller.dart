import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:trip_picker/view/android/auth/login_signup/android_login_signup_screen.dart';

import '../../../main.dart';

class LoadingController extends GetxController {
  static LoadingController get instance {
    return Get.find<LoadingController>();
  }

//============= Variables =============\\
  var isLoading = false.obs;

//============= Load BottomNavView =============\\
  loadHome() async {
    isLoading.value = true;
    update();

    // await UserController.instance.getUserProfile();

    // await Get.offAll(
    //   () => const AndroidBottomNavigationView(),
    //   routeName: "/home",
    //   fullscreenDialog: true,
    //   curve: Curves.easeInOut,
    //   predicate: (routes) => false,
    //   popGesture: false,
    //   transition: Get.defaultTransition,
    // );

    isLoading.value = true;
    update();
  }

  //============= Logout =============\\
  logout() async {
    isLoading.value = true;
    update();

    // UserController.deleteUserSignupData();

    //Clear the user token
    await prefs.setString("userToken", "");

    await Future.delayed(const Duration(seconds: 2));

    await Get.offAll(
      () => const AndroidLoginSignupScreen(),
      routeName: "/login",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );

    isLoading.value = true;
    update();
  }

//============= Load  =============\\
}
