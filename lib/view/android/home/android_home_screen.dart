import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';

class AndroidHomeScreen extends GetView<HomeScreenController> {
  const AndroidHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(HomeScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    // var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [],
          ),
        ),
      ),
    );
  }
}
