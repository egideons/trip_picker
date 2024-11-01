import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/auth/onboarding_controller.dart';

class AndroidOnboardingScreen extends StatelessWidget {
  const AndroidOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(OnboardingController());

    var colorScheme = Theme.of(context).colorScheme;

    return GetBuilder<OnboardingController>(
      init: OnboardingController(),
      builder: (controller) {
        return GestureDetector(
          onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
          child: Scaffold(
            backgroundColor: colorScheme.surface,
            body: Column(
              children: [],
            ),
          ),
        );
      },
    );
  }
}
