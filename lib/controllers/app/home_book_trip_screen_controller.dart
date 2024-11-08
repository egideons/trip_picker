import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/main.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/view/android/book_trip/content/payment_method_modal.dart';
import 'package:trip_picker/view/android/book_trip/content/searching_for_driver_modal.dart';
import 'package:trip_picker/view/android/trip/android_trip_screen.dart';

class HomeBookTripScreenController extends GetxController {
  static HomeBookTripScreenController get instance {
    return Get.find<HomeBookTripScreenController>();
  }

  @override
  void onInit() {
    requestLocationPermission();
    // // Listener to update thumb position and display distance in real-time
    // ever(currentDistance, (_) => updateThumbPosition());
    selectedCabIndex.value = prefs.getInt("selectedCabIndex") ?? -1;
    bookTripButtonIsEnabled.value = selectedCabIndex.value != -1;
    super.onInit();
  }

  @override
  void onClose() {
    bookRideTimer?.cancel();
    super.onClose();
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
    updateThumbPosition();
  }

  openPanel() async {
    await panelController.open();
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
    if (panelController.isPanelClosed) {
      if (headerSearchSectionIsVisible.value) {
        headerSearchSectionIsVisible.value = false;
        if (pickupFieldIsActive.value || destinationFieldIsActive.value) {
          pickupFieldIsActive.value = false;
          destinationFieldIsActive.value = false;
        }
      }
    }

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
  var panelBannerIsVisible = false.obs;
  var panelBannerHasButton = false.obs;
  var readyToBookTrip = false.obs;

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
  showHeaderSearchSection() async {
    if (pickupEC.text.isNotEmpty && destinationEC.text.isNotEmpty) {
      headerSearchSectionIsVisible.value = true;
      FocusManager.instance.primaryFocus?.unfocus();
      await panelController.open();
      destinationFN.requestFocus();
    } else {
      if (panelController.isPanelOpen) await panelController.close();
      headerSearchSectionIsVisible.value = true;
      // hideCollapsedSection.value = true;
      destinationFN.requestFocus();
      pickupEC = TextEditingController(text: currentLocation.value);
    }
  }

  hideSearchField() {
    if (pickupEC.text.isEmpty && destinationEC.text.isEmpty) {
      hideCollapsedSection.value = false;
      headerSearchSectionIsVisible.value = false;
    }
  }

  pickupFieldOnChanged(String value) async {
    if (value.isEmpty) {
      pickupFieldIsActive.value = false;
      hideSearchField();
    } else {
      if (panelController.isPanelOpen) await panelController.close();
      pickupFieldIsActive.value = true;
      stop1FieldIsActive.value = false;
      stop2FieldIsActive.value = false;
      destinationFieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  stop1FieldOnChanged(String value) async {
    if (value.isEmpty) {
      stop1FieldIsActive.value = false;
    } else {
      if (panelController.isPanelOpen) await panelController.close();
      stop1FieldIsActive.value = true;
      stop2FieldIsActive.value = false;
      destinationFieldIsActive.value = false;
      pickupFieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  stop2FieldOnChanged(String value) async {
    if (value.isEmpty) {
      stop2FieldIsActive.value = false;
    } else {
      if (panelController.isPanelOpen) await panelController.close();
      stop2FieldIsActive.value = true;
      destinationFieldIsActive.value = false;
      pickupFieldIsActive.value = false;
      stop1FieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  destinationFieldOnChanged(String value) async {
    if (value.isEmpty) {
      destinationFieldIsActive.value = false;
      hideSearchField();
    } else {
      if (panelController.isPanelOpen) await panelController.close();
      destinationFieldIsActive.value = true;
      pickupFieldIsActive.value = false;
      stop1FieldIsActive.value = false;
      stop2FieldIsActive.value = false;
      hideCollapsedSection.value = true;
    }
  }

  selectPickupSuggestion() async {
    pickupEC.text = pickupSuggestion.value;
    pickupFieldIsActive.value = false;
    stop1FieldIsActive.value = false;
    stop2FieldIsActive.value = false;
    destinationFieldIsActive.value = false;
    hideCollapsedSection.value = false;
    if (destinationEC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (panelController.isPanelClosed) await panelController.open();
    }
  }

  selectDestinationSuggestion() async {
    if (panelController.isPanelClosed) await panelController.open();
    destinationEC.text = destinationSuggestion.value;
    pickupFieldIsActive.value = false;
    stop1FieldIsActive.value = false;
    stop2FieldIsActive.value = false;
    destinationFieldIsActive.value = false;
    hideCollapsedSection.value = false;
    if (pickupEC.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      if (panelController.isPanelClosed) await panelController.open();
    }
  }

  showPanelBanner() {
    panelBannerIsVisible.value = true;
  }

  hidePanelBanner() {
    panelBannerIsVisible.value = false;
  }

  //==================================== Distance Slider =========================================\\

  //============= Booleans =============\\

  //============= Variables =============\\
  final double maxDistance = 80467.2; // Max distance in meters (50 miles)
  final double mileInMeters = 1609.0;
  final double kmInMeters = 1000.0;

  // Observable current distance (starting at 1 mile or 1609 meters)
  var currentDistance = 10230.0.obs;

  // Observable for thumb position and displayed distance
  var thumbPosition = 0.0.obs;
  var displayDistance = ''.obs;

  //============= Functions =============\\
  // Function to update the thumb position based on the screen width and max distance
  void updateThumbPosition() {
    thumbPosition.value = (currentDistance.value / maxDistance) *
        (MediaQuery.sizeOf(Get.context!).width - 40);
    updateDisplayDistance();
  }

  // Function to update display distance with the correct units
  void updateDisplayDistance() {
    if (currentDistance.value >= mileInMeters) {
      // Convert to miles and round to 1 decimal
      displayDistance.value =
          '${(currentDistance.value / mileInMeters).toStringAsFixed(1)} mi';
    } else if (currentDistance.value >= kmInMeters) {
      // Convert to kilometers and round to 1 decimal
      displayDistance.value =
          '${(currentDistance.value / kmInMeters).toStringAsFixed(1)} km';
    } else {
      // Display in meters
      displayDistance.value = '${currentDistance.value.toStringAsFixed(0)} m';
    }
  }

  //==================================== Select Cab Type =========================================\\

  //============= Booleans =============\\
  var bookTripButtonIsEnabled = false.obs;

  //============= Variables =============\\
  var cabs = [
    {
      "name": "Basic",
      "icon": Assets.basicCabIconPng,
    },
    {
      "name": "Premium",
      "icon": Assets.premiumCabIconPng,
    },
  ];

  var selectedCabIndex = (-1).obs;

  var cabIsSelected = [
    false,
    false,
  ].obs;

  //============= Functions =============\\
  void selectCab(int index) {
    // Toggle selection: if the same cab is tapped, deselect it
    if (selectedCabIndex.value == index) {
      selectedCabIndex.value = -1;
      bookTripButtonIsEnabled.value = false;
      prefs.remove("selectedCabIndex");
    } else {
      selectedCabIndex.value = index;
      bookTripButtonIsEnabled.value = true;
      prefs.setInt("selectedCabIndex", index);
    }
  }

  selectPaymentMethod() async {
    var size = Get.context!.size;
    var colorScheme = Theme.of(Get.context!).colorScheme;
    await panelController.close();

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      enableDrag: true,
      context: Get.context!,
      useSafeArea: true,
      isDismissible: true,
      barrierColor: kTransparentColor,
      backgroundColor: kTransparentColor,
      constraints:
          BoxConstraints(maxHeight: size!.height / 1.4, minWidth: size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return selectPaymentMethodModal(
          HomeBookTripScreenController.instance,
          size,
          colorScheme,
        );
      },
    );
  }

  //==================================== Book Trip =========================================\\

  //============= Booleans =============\\
  var searchingForDriver = false.obs;
  var cabDriverFound = false.obs;
  var driverIsArriving = false.obs;

  //============= Variables =============\\
  Timer? bookRideTimer;
  var progress = .0.obs;

  //============= Functions =============\\

  // Method to update the progress
  void updateDriverSearchProgress(double value) {
    if (value >= 0.0 && value <= 1.0) {
      progress.value = value;
      log("Progress: ${progress.value}");
    }
  }

  // Start the progress simulation with a Timer
  void simulateDriverSearchProgress() {
    progress.value = 0.0;
    cabDriverFound.value = false;

    bookRideTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (progress.value < 0.9) {
        updateDriverSearchProgress(progress.value + 0.1);
        searchingForDriver.value = true;
      } else {
        // Directly set progress to 1.0 on the last step
        updateDriverSearchProgress(1.0);
        cabDriverFound.value = true;
        searchingForDriver.value = false;
        log("Driver found: ${cabDriverFound.value}");
        cancelProgress();
        await Future.delayed(const Duration(seconds: 2));
        Get.close(0);

        await Get.offAll(
          () => const AndroidTripScreen(),
          routeName: "/home-trip",
          fullscreenDialog: true,
          curve: Curves.easeInOut,
          predicate: (routes) => false,
          popGesture: false,
          transition: Get.defaultTransition,
        );
      }
    });
  }

  // Cancel the progress simulation
  void cancelProgress() {
    bookRideTimer?.cancel();
  }

  Future<void> showSearchingForDriverModal() async {
    var size = Get.context!.size;
    var colorScheme = Theme.of(Get.context!).colorScheme;
    await panelController.close();

    simulateDriverSearchProgress();

    await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: false,
      enableDrag: false,
      context: Get.context!,
      useSafeArea: true,
      isDismissible: false,
      barrierColor: kTransparentColor,
      backgroundColor: kTransparentColor,
      constraints:
          BoxConstraints(maxHeight: size!.height / 3.6, minWidth: size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (context) {
        return searchingForDriverModal(
          HomeBookTripScreenController.instance,
          size,
          colorScheme,
        );
      },
    );
  }
}
