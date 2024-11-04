import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/auth/success_screen_controller.dart';
import 'package:trip_picker/controllers/auth/verfy_email_otp_controller.dart';
import 'package:trip_picker/theme/colors.dart';

import '../../../../constants/consts.dart';

class AndroidSuccessScreen extends GetView<VerifyEmailOtpController> {
  const AndroidSuccessScreen({super.key, this.loadData});
  final void Function()? loadData;

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(SuccessScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    // var size = MediaQuery.sizeOf(context);

    Timer(Duration.zero, loadData ?? () {});

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              40.toHeight,
              SvgPicture.asset(Assets.doubleGreenTickIconSvg),
              Text(
                "Successful",
                textAlign: TextAlign.center,
                style: defaultTextStyle(
                  color: kDefaultTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                "Trip Picker has confirmed your verification",
                textAlign: TextAlign.center,
                style: defaultTextStyle(
                  color: kTextGreyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
