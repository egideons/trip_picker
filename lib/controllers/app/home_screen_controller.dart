import 'dart:async';

import 'package:flutter/widgets.dart';
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
  var panelIsVisible = false.obs;
  var panelIsOpen = false.obs;
  var headerSearchSectionIsVisible = false.obs;

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

  tapOnGoogleMap(LatLng argument) {
    // if (headerSearchSectionIsVisible.value = true) hideSearchField();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  //==================================== Search field =========================================\\

  //============= Variables =============\\
  var currentLocation = "No 12, GRA, Okumgbowa street".obs;
  var pickupSuggestion = "No 12, GRA, Okumgbowa street".obs;
  var destinationSuggestion = "No 24, GRA, Okumgbowa street".obs;

  //============= Keys =============\\
  final searchFieldFormKey = GlobalKey<FormState>();

  //============= Booleans =============\\
  var pickupFieldIsActive = false.obs;
  var stop1FieldIsActive = false.obs;
  var stop2FieldIsActive = false.obs;
  var destinationFieldIsActive = false.obs;
  var hideCollapsedSection = false.obs;

  //============= Focus Nodes =============\\
  var pickupEC = TextEditingController();
  var stop1EC = TextEditingController();
  var stop2EC = TextEditingController();
  var destinationEC = TextEditingController();

  //============= Focus Nodes =============\\
  var pickupFN = FocusNode();
  var stop1FN = FocusNode();
  var stop2FN = FocusNode();
  var destinationFN = FocusNode();

  //============= Functions =============\\
  showHeaderSearchSection() {
    if (panelController.isPanelOpen) panelController.close();
    headerSearchSectionIsVisible.value = true;
    hideCollapsedSection.value = true;
    pickupFN.requestFocus();
    pickupEC = TextEditingController(text: currentLocation.value);
  }

  hideSearchField() {
    if (pickupEC.text.isEmpty && destinationEC.text.isEmpty) {
      hideCollapsedSection.value = false;
      headerSearchSectionIsVisible.value = false;
    }
  }

  pickupFieldOnChanged(String value) {
    if (value.isEmpty) {
      pickupFieldIsActive.value = false;
      hideSearchField();
    } else {
      if (panelController.isPanelOpen) panelController.close();
      pickupFieldIsActive.value = true;
      stop1FieldIsActive.value = false;
      stop2FieldIsActive.value = false;
      destinationFieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  stop1FieldOnChanged(String value) {
    if (value.isEmpty) {
      stop1FieldIsActive.value = false;
    } else {
      if (panelController.isPanelOpen) panelController.close();
      stop1FieldIsActive.value = true;
      stop2FieldIsActive.value = false;
      destinationFieldIsActive.value = false;
      pickupFieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  stop2FieldOnChanged(String value) {
    if (value.isEmpty) {
      stop2FieldIsActive.value = false;
    } else {
      if (panelController.isPanelOpen) panelController.close();
      stop2FieldIsActive.value = true;
      destinationFieldIsActive.value = false;
      pickupFieldIsActive.value = false;
      stop1FieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  destinationFieldOnChanged(String value) {
    if (value.isEmpty) {
      destinationFieldIsActive.value = false;
      hideSearchField();
    } else {
      if (panelController.isPanelOpen) panelController.close();
      destinationFieldIsActive.value = true;
      pickupFieldIsActive.value = false;
      stop1FieldIsActive.value = false;
      stop2FieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  selectPickupSuggestion() {
    if (panelController.isPanelOpen) panelController.close();
    pickupEC.text = pickupSuggestion.value;
    pickupFieldIsActive.value = false;
    stop1FieldIsActive.value = false;
    stop2FieldIsActive.value = false;
    destinationFieldIsActive.value = false;
    hideCollapsedSection.value = false;
  }

  selectDestinationSuggestion() {
    if (panelController.isPanelOpen) panelController.close();
    destinationEC.text = destinationSuggestion.value;
    pickupFieldIsActive.value = false;
    stop1FieldIsActive.value = false;
    stop2FieldIsActive.value = false;
    destinationFieldIsActive.value = false;
    hideCollapsedSection.value = false;
  }
}
