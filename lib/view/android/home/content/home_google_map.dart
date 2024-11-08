import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';

homeGoogleMap(
  HomeScreenController controller,
  Size size,
) {
  return GoogleMap(
    onTap: controller.tapOnGoogleMap,
    mapType: MapType.normal,
    compassEnabled: true,
    indoorViewEnabled: true,
    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
    tiltGesturesEnabled: true,
    zoomControlsEnabled: false,
    zoomGesturesEnabled: true,
    fortyFiveDegreeImageryEnabled: true,
    myLocationButtonEnabled: false,
    myLocationEnabled: true,
    cameraTargetBounds: CameraTargetBounds.unbounded,
    buildingsEnabled: false,
    rotateGesturesEnabled: true,
    scrollGesturesEnabled: true,
    onMapCreated: controller.onMapCreated,
    padding: controller.panelIsOpen.value
        ? EdgeInsets.only(left: 10, bottom: size.height * .4)
        : EdgeInsets.only(left: 10, bottom: size.height * .14),
    initialCameraPosition: const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14,
    ),
  );
}
