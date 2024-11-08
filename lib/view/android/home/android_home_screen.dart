import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/home/content/collapsed_section.dart';
import 'package:trip_picker/view/android/home/content/destination_map_suggestions.dart';
import 'package:trip_picker/view/android/home/content/home_google_map.dart';
import 'package:trip_picker/view/android/home/content/home_header.dart';
import 'package:trip_picker/view/android/home/content/panel_section.dart';
import 'package:trip_picker/view/android/home/content/pickup_map_suggestions.dart';

class AndroidHomeScreen extends GetView<HomeScreenController> {
  const AndroidHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(HomeScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: GetBuilder<HomeScreenController>(
          init: HomeScreenController(),
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
                                homeGoogleMap(controller, size),
                            panel: homePanelSection(
                              controller,
                              colorScheme,
                              size,
                            ),
                            collapsed: controller.hideCollapsedSection.value
                                ? SizedBox()
                                : homeCollapsedSection(controller),
                          ),
                    Positioned(
                      child: homeHeader(
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
                          return homePickupMapSuggestions(
                            controller,
                            colorScheme,
                            size,
                          );
                        } else if (controller.destinationFieldIsActive.isTrue) {
                          return homeDestinationMapSuggestions(
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
                            bottom: size.height * .14,
                            right: 20,
                            child: locateUserButton(colorScheme),
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

  locateUserButton(ColorScheme colorScheme) {
    return IconButton(
      onPressed: () {},
      tooltip: "Go to my location",
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
    );
  }
}
