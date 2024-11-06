import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/app/home_booking_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/home_book_trip/content/destination_map_suggestions.dart';
import 'package:trip_picker/view/android/home_book_trip/content/home_book_trip_google_map.dart';
import 'package:trip_picker/view/android/home_book_trip/content/home_book_trip_header.dart';
import 'package:trip_picker/view/android/home_book_trip/content/panel_section.dart';
import 'package:trip_picker/view/android/home_book_trip/content/pickup_map_suggestions.dart';

class AndroidHomeBookTripScreen extends GetView<HomeBookTripScreenController> {
  const AndroidHomeBookTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(HomeBookTripScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: GetBuilder<HomeBookTripScreenController>(
          init: HomeBookTripScreenController(),
          builder: (controller) {
            return Obx(
              () {
                return Stack(
                  children: [
                    controller.panelIsVisible.value
                        ? SizedBox()
                        : SlidingUpPanel(
                            controller: controller.panelController,
                            maxHeight: size.height / 2.4,
                            // minHeight: size.height * .26,
                            backdropEnabled: true,
                            backdropTapClosesPanel: true,
                            panelSnapping: true,
                            isDraggable: true,
                            parallaxEnabled: true,
                            renderPanelSheet:
                                controller.panelIsOpen.value ? true : false,
                            onPanelSlide: controller.onPanelSlide,
                            onPanelOpened: controller.onPanelOpened,
                            onPanelClosed: controller.onPanelClosed,
                            backdropColor: kTransparentColor,
                            backdropOpacity: .2,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(32)),

                            body: // controller.userPosition == null
                                //     ? Center(
                                //         child: CircularProgressIndicator(
                                //           color: colorScheme.primary,
                                //         ),
                                //       )
                                //     :
                                homeBookTripGoogleMap(controller),
                            panel: homeBookTripPanelSection(
                              controller,
                              colorScheme,
                              size,
                            ),
                            // collapsed: controller.hideCollapsedSection.value
                            //     ? SizedBox()
                            //     : homeBookTripCollapsedSection(controller),
                          ),
                    Positioned(
                      child: homeBookTripHeader(
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
                          return homeBookTripPickupMapSuggestions(
                            controller,
                            colorScheme,
                            size,
                          );
                        } else if (controller.destinationFieldIsActive.isTrue) {
                          return homeBookTripDestinationMapSuggestions(
                            controller,
                            colorScheme,
                            size,
                          );
                        } else {
                          return SizedBox();
                        }
                      }(),
                    ),
                    controller.panelIsOpen.value ||
                            controller.hideCollapsedSection.value
                        ? SizedBox()
                        : Positioned(
                            bottom: 140,
                            right: 20,
                            child: IconButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                backgroundColor: colorScheme.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: Image.asset(
                                Assets.myLocationIconPng,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ).animate().fade(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeInOut,
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
