import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/consts.dart';

class LoginSignupController extends GetxController {
  static LoginSignupController get instance {
    return Get.find<LoginSignupController>();
  }

  //============= Booleans ================\\
  var shouldAnimate = true.obs;

  //=============================== Login Section  ====================================\\

  //============= Booleans ================\\
  var isLoginPage = true.obs;
  var isLoadingLogin = false.obs;
  var loginFormIsValid = false.obs;

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

  loginPhoneFieldOnChanged(String value) {
    var phoneRegExp = RegExp(RegexPatterns.mobilePattern);
    if (value.isEmpty) {
      loginFormIsValid.value = false;
    } else if (!phoneRegExp.hasMatch(loginPhoneNumberEC.text)) {
      loginFormIsValid.value = false;
    } else {
      loginFormIsValid.value = true;
    }
  }

  //=============================== Signup Section  ====================================\\

  //============= Booleans ================\\
  var isLoadingSignup = false.obs;

  //============= Keys ================\\
  final signupFormKey = GlobalKey<FormState>();

  //============= Controllers ================\\

  //============= Focus Nodes ================\\

  //================ Functions ==================\\
  selectSignupPage() async {
    isLoginPage.value = false;
  }
}
