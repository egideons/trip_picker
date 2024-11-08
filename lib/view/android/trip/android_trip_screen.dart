import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/view/android/trip/content/trip_header.dart';
import 'package:trip_picker/view/android/trip/content/trip_locate_user_button.dart';
import 'package:trip_picker/view/android/trip/content/trip_panel.dart';
import 'package:trip_picker/view/android/trip/content/tripper_container.dart';

class AndroidTripScreen extends GetView<TripScreenController> {
  const AndroidTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(TripScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: GetBuilder<TripScreenController>(
          init: TripScreenController(),
          builder: (controller) {
            return Obx(
              () {
                return Stack(
                  children: [
                    tripPanel(controller, size, colorScheme),
                    // Positioned(
                    //   top: 44,
                    //   left: 10,
                    //   right: 10,
                    //   child: tripHeader(controller, size, colorScheme),
                    // ),
                    controller.driverIsArriving.value
                        ? SizedBox()
                        : tripLocateUserButton(
                            colorScheme,
                            controller,
                            size,
                          ),
                    Positioned(
                      top: 44,
                      left: 10,
                      right: 10,
                      child: tripHeader(controller, size, colorScheme),
                    ),
                    controller.tripHasStarted.value
                        ? Positioned(
                            bottom: controller.panelIsOpen.value
                                ? size.height * .76
                                : size.height * .28,
                            left: 10,
                            child: tripperContainer(
                              colorScheme,
                              controller,
                              size,
                            ),
                          )
                        : SizedBox(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
