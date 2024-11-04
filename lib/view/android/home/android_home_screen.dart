import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/view/android/home/content/home_google_map.dart';
import 'package:trip_picker/view/android/home/content/home_header.dart';
import 'package:trip_picker/view/android/home/content/panel_section.dart';

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
                    SlidingUpPanel(
                      controller: controller.panelController,
                      maxHeight: size.height / 2,
                      // minHeight: size.height * .26,
                      backdropEnabled: true,
                      backdropTapClosesPanel: true,
                      panelSnapping: false,
                      isDraggable: true,
                      parallaxEnabled: true,
                      renderPanelSheet:
                          controller.panelIsOpen.value ? true : false,
                      onPanelSlide: controller.onPanelSlide,
                      onPanelOpened: controller.onPanelOpened,
                      onPanelClosed: controller.onPanelClosed,
                      backdropColor: kTransparentColor,
                      backdropOpacity: .2,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),

                      body: // controller.userPosition == null
                          //     ? Center(
                          //         child: CircularProgressIndicator(
                          //           color: colorScheme.primary,
                          //         ),
                          //       )
                          //     :
                          homeGoogleMap(controller),
                      panel: panelSection(
                        controller,
                        colorScheme,
                        size,
                      ),
                      collapsed: Container(
                        margin:
                            const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                        child: AndroidElevatedButton(
                          title: "Select Location",
                          onPressed: controller.selectLocation,
                          borderRadius: 10,
                        ),
                      ),
                    ),
                    Positioned(
                      child: homeHeader(
                        controller,
                        colorScheme,
                        size,
                      ),
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
