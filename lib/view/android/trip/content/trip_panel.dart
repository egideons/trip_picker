import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/trip/content/trip_collapsed_panel.dart';
import 'package:trip_picker/view/android/trip/content/trip_google_map.dart';
import 'package:trip_picker/view/android/trip/content/trip_panel_section.dart';

tripPanel(
  TripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  return SlidingUpPanel(
    controller: controller.panelController,
    maxHeight: size.height * .8,
    minHeight: size.height * .32,
    backdropEnabled: true,
    backdropTapClosesPanel: true,
    panelSnapping: true,
    isDraggable: controller.panelEnabled.value,
    parallaxEnabled: true,
    color: Colors.transparent,
    renderPanelSheet: controller.panelIsOpen.value ? true : false,
    onPanelSlide: controller.onPanelSlide,
    onPanelOpened: controller.onPanelOpened,
    onPanelClosed: controller.onPanelClosed,
    backdropColor: kTransparentColor,
    backdropOpacity: .2,
    boxShadow: [BoxShadow(color: kTransparentColor)],
    borderRadius: const BorderRadius.all(Radius.circular(32)),
    body:
        // controller.userPosition == null
        //     ? Center(
        //         child: CircularProgressIndicator(
        //           color: colorScheme.primary,
        //         ),
        //       )
        //     :
        tripGoogleMap(controller, size),
    panel: tripPanelSection(controller, size, colorScheme),
    collapsed: tripCollapsedPanel(controller, size, colorScheme),
  );
}
