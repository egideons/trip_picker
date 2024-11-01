import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSignupController extends GetxController {
  static LoginSignupController get instance {
    return Get.find<LoginSignupController>();
  }

  var currentPage = 0.obs;
  var isLoginPage = true.obs;
  var shouldAnimate = true.obs;
  var isLoadingLogin = false.obs;
  var isLoadingSignup = false.obs;

  selectLoginPage() async {
    shouldAnimate.value = true;
    isLoginPage.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    shouldAnimate.value = false;
  }

  selectSignupPage() async {
    shouldAnimate.value = true;
    isLoginPage.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    shouldAnimate.value = false;
  }

  //========== Keys ================\\
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  //==========  ================\\
}
