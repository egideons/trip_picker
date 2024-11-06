import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/controllers/app/home_promo_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/home_promo/content/collapsed_section.dart';
import 'package:trip_picker/view/android/home_promo/content/destination_map_suggestions.dart';
import 'package:trip_picker/view/android/home_promo/content/home_promo_google_map.dart';
import 'package:trip_picker/view/android/home_promo/content/home_promo_header.dart';
import 'package:trip_picker/view/android/home_promo/content/panel_section.dart';
import 'package:trip_picker/view/android/home_promo/content/pickup_map_suggestions.dart';

class AndroidHomePromoScreen extends GetView<HomePromoScreenController> {
  const AndroidHomePromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Initialize the controller
    Get.put(HomePromoScreenController());

    var colorScheme = Theme.of(context).colorScheme;
    var size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: GetBuilder<HomePromoScreenController>(
          init: HomePromoScreenController(),
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
                                homePromoGoogleMap(controller),
                            panel: panelSection(
                              controller,
                              colorScheme,
                              size,
                            ),
                            collapsed: controller.hideCollapsedSection.value
                                ? SizedBox()
                                : collapsedSection(controller),
                          ),
                    Positioned(
                      child: homePromoHeader(
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
                          return homePromoPickupMapSuggestions(
                            controller,
                            colorScheme,
                            size,
                          );
                        } else if (controller.destinationFieldIsActive.isTrue) {
                          return homePromoDestinationMapSuggestions(
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
