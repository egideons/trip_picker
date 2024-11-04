import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/home/content/home_google_map.dart';

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
              return SafeArea(
                child: Stack(
                  children: [
                    SlidingUpPanel(
                      controller: controller.panelController,
                      maxHeight: size.height,
                      backdropTapClosesPanel: true,
                      minHeight: size.height * .26,
                      backdropEnabled: true,
                      defaultPanelState: PanelState.CLOSED,
                      panelSnapping: false,
                      backdropColor: kTransparentColor,
                      backdropOpacity: 0,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      body: // controller.userPosition == null
                          //     ? Center(
                          //         child: CircularProgressIndicator(
                          //           color: colorScheme.primary,
                          //         ),
                          //       )
                          //     :
                          homeGoogleMap(controller),
                      panel: Container(
                        decoration: ShapeDecoration(
                          color: colorScheme.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
