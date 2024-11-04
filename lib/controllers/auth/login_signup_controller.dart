import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:trip_picker/controllers/others/api_processor_controller.dart';
import 'package:trip_picker/view/android/auth/verify_email_otp/android_verify_email_otp_screen.dart';
import 'package:trip_picker/view/android/auth/verify_phone_otp/android_verify_phone_otp_screen.dart';

class LoginSignupController extends GetxController {
  static LoginSignupController get instance {
    return Get.find<LoginSignupController>();
  }

  //============= Booleans ================\\
  var shouldAnimate = true.obs;

  //=============================== Login Section  ====================================\\

  //============= Variables ================\\
  var loginCountryDialCode = "".obs;

  //============= Booleans ================\\
  var isLoginPage = true.obs;
  var isLoadingLogin = false.obs;
  var loginPhoneFieldActive = false.obs;

  //============= Keys ================\\
  final loginFormKey = GlobalKey<FormState>();

  //============= Controllers ================\\
  final loginPhoneNumberEC = TextEditingController();

  //============= Focus Nodes ================\\
  final loginPhoneNumberFN = FocusNode();

  //================ Functions ==================\\
  selectLoginPage() async {
    isLoginPage.value = true;
  }

  loginPhoneOnchanged(PhoneNumber value) {
    if (value.number.isEmpty) {
      loginPhoneFieldActive.value = false;
    } else {
      loginPhoneFieldActive.value = true;
    }
    loginCountryDialCode.value = value.countryCode;
    log("This is the country dial code: ${loginCountryDialCode.value}");
  }

  loginOnCountryChanged(Country value) {
    loginCountryDialCode.value = value.dialCode;
    log("This is the country dial code: ${loginCountryDialCode.value}");
  }

  loginOnSubmitted(String value) {
    login();
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      if (loginPhoneNumberEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your phone number");
        return;
      }
      isLoadingLogin.value = true;
      log("This is the login data: $loginCountryDialCode${loginPhoneNumberEC.text}");
      await Future.delayed(const Duration(seconds: 3));

      // Get.toNamed(Routes.verifyPhoneOtp, preventDuplicates: true);
      await Get.offAll(
        () => const AndroidVerifyPhoneOtpScreen(),
        routeName: "/verify-phone-otp",
        arguments: {"phone": loginCountryDialCode + loginPhoneNumberEC.text},
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
      isLoadingLogin.value = false;
    }
  }

  //=============================== Signup Section  ====================================\\

  //============= Variables ================\\
  var signupCountryDialCode = "".obs;

  //============= Booleans ================\\
  var isLoadingSignup = false.obs;
  var signupPhoneFieldActive = false.obs;
  var signupEmailFieldActive = false.obs;
  var signupOccupationFieldActive = false.obs;

  //============= Keys ================\\
  final signupFormKey = GlobalKey<FormState>();

  //============= Controllers ================\\
  final signupPhoneNumberEC = TextEditingController();
  final signupEmailEC = TextEditingController();
  final signupOccupationEC = TextEditingController();

  //============= Focus Nodes ================\\
  final signupPhoneNumberFN = FocusNode();
  final signupEmailFN = FocusNode();
  final signupOccupationFN = FocusNode();

  //================ Functions ==================\\
  selectSignupPage() async {
    isLoginPage.value = false;
  }

  signupPhoneOnchanged(String value) {
    if (value.isEmpty) {
      signupPhoneFieldActive.value = false;
    } else {
      signupPhoneFieldActive.value = true;
    }
    signupCountryDialCode.value = value;
  }

  signupOnCountryChanged(Country value) {
    signupCountryDialCode.value = value.dialCode;
  }

  signupEmailOnchanged(String value) {
    if (value.isEmpty) {
      signupEmailFieldActive.value = false;
    } else {
      signupEmailFieldActive.value = true;
    }
  }

  signupOccupationOnchanged(String value) {
    if (value.isEmpty) {
      signupOccupationFieldActive.value = false;
    } else {
      signupOccupationFieldActive.value = true;
    }
  }

  signupOnSubmitted(String value) {
    signup();
  }

  Future<void> signup() async {
    if (signupFormKey.currentState!.validate()) {
      signupFormKey.currentState!.save();
      if (signupPhoneNumberEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your phone number");
        return;
      } else if (signupEmailEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your email");
        return;
      } else if (!signupEmailEC.text.isEmail) {
        ApiProcessorController.errorSnack("Please enter a valid email");
        return;
      } else if (signupOccupationEC.text.isEmpty) {
        ApiProcessorController.errorSnack("Please enter your occupation");
        return;
      }
      isLoadingSignup.value = true;
      await Future.delayed(const Duration(seconds: 3));

      // Get.toNamed(Routes.verifyEmailOtp, preventDuplicates: true);
      await Get.offAll(
        () => const AndroidVerifyEmailOtpScreen(),
        routeName: "/verify-email-otp",
        arguments: {"email": signupEmailEC.text},
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );

      isLoadingLogin.value = false;
    }
  }
}
