import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/auth/success_screen_controller.dart';
import 'package:trip_picker/controllers/others/api_processor_controller.dart';
import 'package:trip_picker/view/android/splash_screen/success/android_success_screen.dart';

class VerifyEmailOtpController extends GetxController {
  static VerifyEmailOtpController get instance {
    return Get.find<VerifyEmailOtpController>();
  }

  @override
  void onInit() {
    // Initialize TextEditingControllers
    pin1EC = TextEditingController();
    pin2EC = TextEditingController();
    pin3EC = TextEditingController();
    pin4EC = TextEditingController();

    // Request OTP and set focus
    requestOTP();
    pin1FN.requestFocus();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  //============= Variables ================\\
  var userEmail = Get.arguments?['email'] ?? "";
  var loginResponseMessage = "".obs;
  late Timer _timer;
  var secondsRemaining = 30.obs;
  final originalPin1Text = ''.obs;
  final maskedPin1Text = ''.obs;
  final originalPin2Text = ''.obs;
  final maskedPin2Text = ''.obs;
  final originalPin3Text = ''.obs;
  final maskedPin3Text = ''.obs;
  final originalPin4Text = ''.obs;
  final maskedPin4Text = ''.obs;

  //============= Booleans ================\\
  var isLoading = false.obs;
  var timerComplete = false.obs;
  var pin1FieldIsActive = false.obs;
  var pin2FieldIsActive = false.obs;
  var pin3FieldIsActive = false.obs;
  var pin4FieldIsActive = false.obs;

  //============= Keys ================\\
  final formKey = GlobalKey<FormState>();

  //============= Controllers ================\\
  late TextEditingController pin1EC;
  late TextEditingController pin2EC;
  late TextEditingController pin3EC;
  late TextEditingController pin4EC;

  //============= Focus Nodes ================\\
  final pin1FN = FocusNode();
  final pin2FN = FocusNode();
  final pin3FN = FocusNode();
  final pin4FN = FocusNode();

  //============= Functions ================\\

  // Masking methods
  void updatePin1Text(String text) {
    originalPin1Text.value = text;
    maskedPin1Text.value = '*' * text.length;
    pin1EC.value = TextEditingValue(
      text: maskedPin1Text.value,
      selection: TextSelection.collapsed(offset: maskedPin1Text.value.length),
    );
  }

  void updatePin2Text(String text) {
    originalPin2Text.value = text;
    maskedPin2Text.value = '*' * text.length;
    pin2EC.value = TextEditingValue(
      text: maskedPin2Text.value,
      selection: TextSelection.collapsed(offset: maskedPin2Text.value.length),
    );
  }

  void updatePin3Text(String text) {
    originalPin3Text.value = text;
    maskedPin3Text.value = '*' * text.length;
    pin3EC.value = TextEditingValue(
      text: maskedPin3Text.value,
      selection: TextSelection.collapsed(offset: maskedPin3Text.value.length),
    );
  }

  void updatePin4Text(String text) {
    originalPin4Text.value = text;
    maskedPin4Text.value = '*' * text.length;
    pin4EC.value = TextEditingValue(
      text: maskedPin4Text.value,
      selection: TextSelection.collapsed(offset: maskedPin4Text.value.length),
    );
  }

  // Updated onChanged methods
  void pin1Onchanged(String value, BuildContext context) {
    if (value.isEmpty) {
      pin1FieldIsActive.value = false;
    }
    if (value.length == 1) {
      pin1FieldIsActive.value = true;
      updatePin1Text(value);
      FocusScope.of(context).nextFocus();
    }
  }

  void pin2Onchanged(String value, BuildContext context) {
    if (value.isEmpty) {
      pin2FieldIsActive.value = false;
      FocusScope.of(context).previousFocus();
    }
    if (value.length == 1) {
      pin2FieldIsActive.value = true;
      updatePin2Text(value);
      FocusScope.of(context).nextFocus();
    }
  }

  void pin3Onchanged(String value, BuildContext context) {
    if (value.isEmpty) {
      pin3FieldIsActive.value = false;
      FocusScope.of(context).previousFocus();
    }
    if (value.length == 1) {
      pin3FieldIsActive.value = true;
      updatePin3Text(value);
      FocusScope.of(context).nextFocus();
    }
  }

  void pin4Onchanged(String value, BuildContext context) {
    if (value.isEmpty) {
      pin4FieldIsActive.value = false;
      FocusScope.of(context).previousFocus();
    }
    if (value.length == 1) {
      pin4FieldIsActive.value = true;
      updatePin4Text(value);
      // FocusScope.of(context).unfocus();
    }
  }

  onSubmitted(String value) {
    submitOTP();
  }

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        timerComplete.value = true;
        _timer.cancel();
      }
    });
  }

  pauseTimer() {
    if (timerComplete.value == false && isLoading.value == true) {
      _timer.cancel();
    }
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void requestOTP() async {
    secondsRemaining.value = 60;
    timerComplete.value = false;
    // var url = ApiUrl.authBaseUrl + ApiUrl.auth + ApiUrl.sendPhoneOTP;

    // Map data = {"phone": userEmail};

    // log("This is the Url: $url");
    // log("This is the OTP Data: $data");

    // Client service
    // var response = await DioClientService.postRequest(
    //   url,
    //   data,
    // );

    // if (response == null) {
    //   isLoading.value = false;
    //   return;
    // }

    // try {
    // Convert to json
    //   dynamic responseJson;
    //   if (response.data is String) {
    //     responseJson = jsonDecode(response.data);
    //   } else {
    //     responseJson = response.data;
    //   }

    //   log("This is the response body ====> ${response.data}");
    //   log("This is the response json ====> $responseJson");

    //   if (response.statusCode == 200) {
    await Future.delayed(const Duration(seconds: 1));
    ApiProcessorController.successSnack(
      "An OTP has been sent to your email",
    );
    startTimer();
    //   } else {
    //     log("Request failed with status: ${response.statusCode}");
    //     log("Response body: ${response.data}");
    //   }
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  Future<void> submitOTP() async {
    if (formKey.currentState!.validate()) {
      if (pin1EC.text.isEmpty ||
          pin2EC.text.isEmpty ||
          pin3EC.text.isEmpty ||
          pin4EC.text.isEmpty) {
        ApiProcessorController.errorSnack(
          "Please fill the form before submitting",
        );
        return;
      }

      formKey.currentState!.save();
      isLoading.value = true;

      //Pause the timer
      pauseTimer();
      timerComplete.value = false;

      // var url = ApiUrl.authBaseUrl + ApiUrl.auth + ApiUrl.verifyOTP;

      //  var otpCode = originalPin1Text.value +
      //     originalPin2Text.value +
      //     originalPin1Text.value +
      //     originalPin1Text.value;

      log("This is the user email:$userEmail");

      // log("This is the Url: $url");

      //HTTP Client Service
      // http.Response? response =
      //     await HttpClientService.postRequest(url, null, data);

      // if (response == null) {
      //   isLoading.value = false;
      //   return;
      // }

      // try {
      // Convert to json
      // dynamic responseJson;

      // responseJson = jsonDecode(response.body);

      // log("This is the response body ====> ${response.body}");

      //Map the response json to the model provided
      // otpResponse.value = VerifyOTPResponseModel.fromJson(responseJson);

      //   if (response.statusCode == 200) {
      //     ApiProcessorController.successSnack("Verification successful");

      await Future.delayed(const Duration(seconds: 3));

      //     await loginUser();

      await Get.offAll(
        () => AndroidSuccessScreen(
          loadData: SuccessScreenController.instance.loadHome,
        ),
        routeName: "/success-screen",
        fullscreenDialog: true,
        curve: Curves.easeInOut,
        predicate: (routes) => false,
        popGesture: false,
        transition: Get.defaultTransition,
      );
      //   } else {
      //     ApiProcessorController.warningSnack(otpResponse.value.message);
      //     log("Request failed with status: ${response.statusCode}");
      //     log("Response body: ${response.body}");
      //     isLoading.value = false;
      //     return;
      //   }
      // } catch (e) {
      //   log(e.toString());
      //   isLoading.value = false;
      //   return;
      // }

      isLoading.value = false;
      //Continue the timer and enable resend button
      startTimer();
    }
  }
}
