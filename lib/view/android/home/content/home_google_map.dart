import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';

homeGoogleMap(HomeScreenController controller) {
  return GoogleMap(
    mapType: MapType.normal,
    compassEnabled: true,
    mapToolbarEnabled: true,
    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
    tiltGesturesEnabled: true,
    zoomControlsEnabled: false,
    zoomGesturesEnabled: true,
    fortyFiveDegreeImageryEnabled: true,
    myLocationButtonEnabled: true,
    liteModeEnabled: false,
    myLocationEnabled: false,
    cameraTargetBounds: CameraTargetBounds.unbounded,
    buildingsEnabled: true,
    rotateGesturesEnabled: true,
    scrollGesturesEnabled: true,
    onMapCreated: controller.onMapCreated,
    padding: controller.panelIsOpen.value
        ? const EdgeInsets.only(bottom: 200)
        : const EdgeInsets.only(left: 10, bottom: 120),
    initialCameraPosition: const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14,
    ),
  );
}
