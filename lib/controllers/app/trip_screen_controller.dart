import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/view/android/book_trip/android_book_trip_screen.dart';

class TripScreenController extends GetxController {
  static TripScreenController get instance {
    return Get.find<TripScreenController>();
  }

  @override
  void onInit() {
    simulateRideProgress();
    super.onInit();
  }

  @override
  void onClose() {
    miningTimer?.cancel();
    milesMinedTimer?.cancel();
    super.onClose();
  }

  //============= Variables =============\\
  Timer? miningTimer;
  Timer? milesMinedTimer;
  var miningCredits = 0.000000.obs;
  var milesMined = 0.00.obs;
  var pickupLocation = "No 12, GRA, Okumgbowa street".obs;
  var destination = "No 12, GRA, Okumgbowa street".obs;
  var stop1 = "No 12, GRA, Okumgbowa street".obs;
  var stop2 = "No 12, GRA, Okumgbowa street".obs;
  var tripHeaderMsg = "".obs;
  var tripPanelMsg = "".obs;
  var ridersImages = [
    Assets.man1Png,
    Assets.man2Png,
    Assets.man3Png,
    Assets.man4Png,
  ].obs;
  //============= Booleans =============\\
  var isLoading = false.obs;
  var panelEnabled = true.obs;
  var panelIsOpen = false.obs;
  var driverIsArriving = false.obs;
  var driverHasArrived = false.obs;
  var tripHasStarted = false.obs;
  var closeToDestination = false.obs;
  var tripEnded = false.obs;

  //============= Controllers =============\\
  var panelController = PanelController();
  final Completer<GoogleMapController> _googleMapController = Completer();
  GoogleMapController? newGoogleMapController;

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

  openPanel() {
    panelController.open();
    onPanelOpened();
  }

  onPanelSlide(double position) {
    if (position > 0.1) {
      panelIsOpen.value = true;
    }
  }

  onPanelOpened() {
    panelIsOpen.value = true;
  }

  onPanelClosed() {
    panelIsOpen.value = false;
  }

  tapOnGoogleMap(LatLng argument) {
    panelController.close();
  }

  // Method to update the mining progress
  void updateMiningProgress(double value) {
    // if (value >= 0.00000 && value <= 1.0) {
    miningCredits.value = value;
    log("Mining credits Progress: ${miningCredits.value}");
    // }
  }

  // Method to update the mining progress
  void updateMilesMinedProgress(double value) {
    // if (value >= 0.00000 && value <= 1.0) {
    milesMined.value = value;
    log("Miles mined Progress: ${milesMined.value}");
    // }
  }

  // Cancel the mining progress simulation
  void cancelMiningProgress() {
    miningTimer?.cancel();
  }

  // Cancel the miles mined progress simulation
  void cancelMilesMinedProgress() {
    milesMinedTimer?.cancel();
  }

  void simulateMiningProgress() async {
    miningCredits.value = 0.000000;
    miningTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        if (tripHasStarted.value == true) {
          updateMiningProgress(miningCredits.value + 0.000001);
        }
      },
    );
  }

  void simulateMilesMinedProgress() async {
    milesMined.value = 0.00;
    miningTimer = Timer.periodic(
      Duration(seconds: 10),
      (timer) async {
        if (tripHasStarted.value == true) {
          updateMilesMinedProgress(milesMined.value + 0.01);
        }
      },
    );
  }

  Future<void> simulateRideProgress() async {
    driverIsArriving.value = true;
    tripHeaderMsg.value = "Arriving in 4 mins";
    tripPanelMsg.value = "Driver is on his way";

    await Future.delayed(const Duration(seconds: 10));
    driverHasArrived.value = true;
    driverIsArriving.value = false;
    tripPanelMsg.value = "";
    tripHeaderMsg.value = "Driver has arrived";
    // Close the panel
    await panelController.close();

    // Disable the panel sliding
    panelEnabled.value = false;

    await Future.delayed(const Duration(seconds: 10));
    tripHasStarted.value = true;
    simulateMiningProgress();
    simulateMilesMinedProgress();
    driverHasArrived.value = false;
    tripHeaderMsg.value = "Trip started, estimated time: 30 mins";

    await Future.delayed(const Duration(seconds: 30));
    closeToDestination.value = true;
    tripHeaderMsg.value = "Your are close to your destination";

    await Future.delayed(const Duration(seconds: 30));
    tripEnded.value = true;
    tripHasStarted.value = false;
    cancelMiningProgress();
    cancelMilesMinedProgress();
    closeToDestination.value = false;
    tripPanelMsg.value = "Trip Ended";
    tripHeaderMsg.value = "You have arrived at your destination";

    await Future.delayed(const Duration(seconds: 2));
    await Get.offAll(
      () => const AndroidBookTripScreen(),
      routeName: "/book-trip",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }
}
