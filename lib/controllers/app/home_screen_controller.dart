import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/main.dart';
import 'package:trip_picker/view/android/book_trip/android_book_trip_screen.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

  @override
  void onInit() {
    requestLocationPermission();
    selectedOptionIndex.value = prefs.getInt("selectedOptionIndex") ?? -1;
    panelCabDestinationTextFieldIsVisible.value =
        selectedOptionIndex.value != -1;
    super.onInit();
  }

  //============= Booleans =============\\
  var panelCabDestinationTextFieldIsVisible = false.obs;
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
    await openPanel();
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
    if (headerSearchSectionIsVisible.value = true) hideSearchField();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  //==================================== Search field =========================================\\

  //============= Variables =============\\
  var currentLocation = "No 12, GRA, Okumgbowa street".obs;
  var destination = "".obs;
  var pickupSuggestion = "No 12, GRA, Okumgbowa street".obs;
  var panelDestination = "What's your destination?".obs;
  var destinationSuggestion = "No 24, GRA, Okumgbowa street".obs;
  var options = [
    {
      "name": "Cab",
      "icon": Assets.cabIconPng,
    },
    {
      "name": "Logistics",
      "icon": Assets.logisticsIconPng,
    },
  ];
  var selectedOptionIndex = (-1).obs;

  //============= Keys =============\\
  final searchFieldFormKey = GlobalKey<FormState>();

  //============= Booleans =============\\
  var pickupFieldIsActive = false.obs;
  var destinationFieldIsActive = false.obs;
  var hideCollapsedSection = false.obs;
  var panelBannerIsVisible = false.obs;
  var panelBannerHasButton = false.obs;
  var readyToBookTrip = false.obs;
  var goToLogisticsButtonIsVisible = false.obs;
  var optionIsSelected = [
    false,
    false,
  ].obs;

  //============= Focus Nodes =============\\
  var pickupEC = TextEditingController();
  var destinationEC = TextEditingController();

  //============= Focus Nodes =============\\
  var pickupFN = FocusNode();
  var destinationFN = FocusNode();

//============= Functions =============\\
  void selectOption(int index) {
    if (selectedOptionIndex.value == index) {
      selectedOptionIndex.value = -1;
      panelCabDestinationTextFieldIsVisible.value = false;
      goToLogisticsButtonIsVisible.value = false;
      prefs.remove("selectedOptionIndex");
    } else {
      selectedOptionIndex.value = index;
      log("This is the selected index: ${selectedOptionIndex.value}");
      if (selectedOptionIndex.value == 0) {
        panelCabDestinationTextFieldIsVisible.value = true;
        goToLogisticsButtonIsVisible.value = false;
      } else if (selectedOptionIndex.value == 1) {
        goToLogisticsButtonIsVisible.value = true;
        panelCabDestinationTextFieldIsVisible.value = false;
      } else {
        panelCabDestinationTextFieldIsVisible.value = false;
        goToLogisticsButtonIsVisible.value = false;
      }
      prefs.setInt("selectedOptionIndex", index);
    }
  }

  showHeaderSearchSection() {
    if (panelController.isPanelOpen) panelController.close();
    headerSearchSectionIsVisible.value = true;
    hideCollapsedSection.value = true;
    destinationFN.requestFocus();
    pickupEC = TextEditingController(text: currentLocation.value);
    destinationEC = TextEditingController(text: destination.value);
  }

  hideSearchField() {
    // if (pickupEC.text.isEmpty && destinationEC.text.isEmpty) {
    hideCollapsedSection.value = false;
    headerSearchSectionIsVisible.value = false;
    // }
  }

  pickupFieldOnChanged(String value) {
    if (value.isEmpty) {
      pickupFieldIsActive.value = false;
      hideSearchField();
    } else {
      if (panelController.isPanelOpen) panelController.close();
      pickupFieldIsActive.value = true;
      destinationFieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  destinationFieldOnChanged(String value) {
    if (value.isEmpty) {
      destinationFieldIsActive.value = false;
      readyToBookTrip.value = false;
      hideSearchField();
    } else {
      if (panelController.isPanelOpen) panelController.close();
      destinationFieldIsActive.value = true;
      pickupFieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  selectPickupSuggestion() {
    if (panelController.isPanelOpen) panelController.close();
    pickupEC.text = pickupSuggestion.value;
    pickupFieldIsActive.value = false;
    destinationFieldIsActive.value = false;
    hideCollapsedSection.value = false;
  }

  selectDestinationSuggestion() {
    destinationEC.text = destinationSuggestion.value;
    pickupFieldIsActive.value = false;
    destinationFieldIsActive.value = false;
    hideCollapsedSection.value = false;
    if (panelController.isPanelClosed) panelController.open();
    readyToBookTrip.value = true;
    FocusManager.instance.primaryFocus?.unfocus();
    panelDestination.value = destinationSuggestion.value;
  }

  showPanelBanner() {
    panelBannerIsVisible.value = true;
  }

  hidePanelBanner() {
    panelBannerIsVisible.value = false;
  }

  bookCabTrip() async {
    await Get.offAll(
      () => const AndroidBookTripScreen(),
      arguments: {'tripDestinationAddress': destinationSuggestion},
      routeName: "/book-trip",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }

  goToLogistics() async {
    // await Get.offAll(
    //   () => const AndroidBookTripScreen(),
    //   routeName: "/book-trip",
    //   fullscreenDialog: true,
    //   curve: Curves.easeInOut,
    //   predicate: (routes) => false,
    //   popGesture: false,
    //   transition: Get.defaultTransition,
    // );
  }
}
