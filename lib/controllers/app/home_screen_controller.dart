import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

  @override
  void onInit() {
    requestLocationPermission();
    super.onInit();
  }

  //============= Variables =============\\

  //============= Booleans =============\\
  var isLocationPermissionGranted = false.obs;
  var isLoading = false.obs;
  var panelIsOpen = false.obs;

  //============= Controllers =============\\
  var panelController = PanelController();
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      isLocationPermissionGranted.value = true;
      update();
    }
    if (status.isDenied) {
      Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  //==================================== Google Maps =========================================\\
  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  // Future<void> loadMapData() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //       'Location permissions are permanently denied, we cannot request permissions.',
  //     );
  //   }
  //   await _getAndGoToUserCurrentLocation();
  // }

  // Future<Position> _getAndGoToUserCurrentLocation() async {
  //   Position userLocation = await Geolocator.getCurrentPosition(
  //     locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  //     // desiredAccuracy: LocationAccuracy.high,
  //   ).then(
  //     (location) => userPosition = location,
  //   );

  //   LatLng latLngPosition =
  //       LatLng(userLocation.latitude, userLocation.longitude);

  //   cameraPosition = CameraPosition(target: latLngPosition, zoom: 20);

  //   newGoogleMapController?.animateCamera(
  //     CameraUpdate.newCameraPosition(cameraPosition!),
  //   );

  //   return userLocation;
  // }

  void onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    newGoogleMapController = controller;
  }

  selectLocation() async {
    openPanel();
  }

  openPanel() {
    panelController.open();
    onPanelOpened();
  }

  onPanelSlide(double position) {
    if (position > 0.1) panelIsOpen.value = true;
  }

  onPanelOpened() {
    panelIsOpen.value = true;
  }

  onPanelClosed() {
    panelIsOpen.value = false;
  }
}
