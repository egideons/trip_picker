import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/app/book_trip_screen_controller.dart';
import 'package:trip_picker/view/android/book_trip/content/book_trip_header.dart';
import 'package:trip_picker/view/android/book_trip/content/book_trip_panel.dart';
import 'package:trip_picker/view/android/book_trip/content/destination_map_suggestions.dart';
import 'package:trip_picker/view/android/book_trip/content/locate_user_button.dart';
import 'package:trip_picker/view/android/book_trip/content/pickup_map_suggestions.dart';

class AndroidBookTripScreen extends GetView<BookTripScreenController> {
  const AndroidBookTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(BookTripScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: GetBuilder<BookTripScreenController>(
          init: BookTripScreenController(),
          builder: (controller) {
            return Obx(
              () {
                return Stack(
                  children: [
                    bookTripPanel(controller, size, colorScheme),
                    Positioned(
                      top: 44,
                      left: 10,
                      right: 10,
                      child: bookTripHeader(
                        controller,
                        colorScheme,
                        size,
                      ),
                    ),
                    Positioned(
                      top: size.height / 4,
                      left: 12,
                      right: 12,
                      child: () {
                        if (controller.pickupFieldIsActive.isTrue) {
                          return bookTripPickupMapSuggestions(
                            controller,
                            colorScheme,
                            size,
                          );
                        } else if (controller.destinationFieldIsActive.isTrue) {
                          return bookTripDestinationMapSuggestions(
                            controller,
                            colorScheme,
                            size,
                          );
                        } else {
                          return SizedBox();
                        }
                      }(),
                    ),
                    // controller.panelIsOpen.value ||
                    controller.hideCollapsedSection.value ||
                            controller.searchingForDriver.value ||
                            controller.driverIsArriving.value ||
                            controller.cabDriverFound.value
                        ? SizedBox()
                        : bookTripLocateUserButton(
                            controller,
                            colorScheme,
                            size,
                          ),
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
