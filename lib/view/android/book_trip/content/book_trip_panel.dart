import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/controllers/app/home_book_trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/book_trip/content/book_trip_google_map.dart';
import 'package:trip_picker/view/android/book_trip/content/panel_section.dart';

bookTripPanel(
  HomeBookTripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  return SlidingUpPanel(
    controller: controller.panelController,
    maxHeight: size.height / 2.4,
    // minHeight: size.height * .26,
    backdropEnabled: true,
    backdropTapClosesPanel: true,
    panelSnapping: true,
    isDraggable: true,
    parallaxEnabled: true,
    renderPanelSheet: controller.panelIsOpen.value ? true : false,
    onPanelSlide: controller.onPanelSlide,
    onPanelOpened: controller.onPanelOpened,
    onPanelClosed: controller.onPanelClosed,
    backdropColor: kTransparentColor,
    boxShadow: [BoxShadow(color: kTransparentColor)],
    backdropOpacity: .2,
    borderRadius: const BorderRadius.all(Radius.circular(32)),
    body: // controller.userPosition == null
        //     ? Center(
        //         child: CircularProgressIndicator(
        //           color: colorScheme.primary,
        //         ),
        //       )
        //     :
        bookTripGoogleMap(controller),
    panel: bookTripDestinationMapSuggestions(controller, colorScheme, size),
    // collapsed: homeBookTripCollapsedSection(controller),
  );
}
