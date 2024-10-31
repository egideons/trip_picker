import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/splash_screen/startup_screen_controller.dart';

class AndroidStartupScreen extends StatelessWidget {
  const AndroidStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(StartupScreenController());

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AndroidStartupScreen'),
        ),
        body: const Center(
          child: Text('Scaffold Body'),
        ),
      ),
    );
  }
}
