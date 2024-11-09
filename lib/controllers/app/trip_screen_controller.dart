import 'dart:async';
import 'dart:developer';

import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/toast/message_alert_toast.dart';
import 'package:trip_picker/view/android/home/android_home_screen.dart';
import 'package:trip_picker/view/android/trip/content/cancel_ride_dialog.dart';
import 'package:trip_picker/view/android/trip/content/driver_rating_dialog.dart';

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

  //==================================== Trip Section =========================================\\

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

    if (rideSimulationIsPaused.value) {
      log("The ride is paused: ${rideSimulationIsPaused.value}");
      // await delayedWithPause(const Duration(seconds: 30));
      // 10-second wait with pausing capability
      if (rideSimulationIsStopped.value) return;
    } else {
      log("The ride is paused: ${rideSimulationIsPaused.value}");

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
      if (panelController.isPanelOpen) await panelController.close();
      showDriverRatingDialog();
    }
  }

  //==================================== Cancel Ride =========================================\\

  //============= Keys =============\\
  var cancelRideFormKey = GlobalKey<FormState>();

  //============= Variables =============\\
  var cancelRideReasons = [
    "Rude driver",
    "Different car",
    "Taking time to arrive",
    "Asked to cancel",
    "Requested for offline ride",
    "Others",
  ];

  //============= Booleans =============\\
  var cancelRideSubmitButtonIsEnabled = false.obs;
  var cancelRideReasonIsSelected =
      [false, false, false, false, false, false].obs;
  var cancelRideOtherOptionIsSelected = false.obs;
  var cancelRideOtherOptionIsActive = false.obs;
  var rideSimulationIsPaused = false.obs;
  var rideSimulationIsStopped = false.obs;

  //============= Controller =============\\
  var cancelRideOtherOptionEC = TextEditingController();
  var cancelRideDialogPageController = PageController().obs;

  //============= Focus Node =============\\
  var cancelRideOtherOptionFN = FocusNode();

  //============= Functions =============\\
  // Function to toggle the state of the checkboxes
  void toggleCancelRideReasonsSelection(int index) {
    if (index == 5) {
      // "Other" checkbox
      cancelRideReasonIsSelected[0] = false;
      cancelRideReasonIsSelected[1] = false;
      cancelRideReasonIsSelected[2] = false;
      cancelRideReasonIsSelected[3] = false;
      cancelRideReasonIsSelected[4] = false;
      cancelRideReasonIsSelected[5] = !cancelRideReasonIsSelected[5];
      cancelRideSubmitButtonIsEnabled.value = false;
      cancelRideReasonIsSelected[5] == true
          ? cancelRideOtherOptionIsSelected.value = true
          : cancelRideOtherOptionIsSelected.value = true;
      cancelRideReasonIsSelected[5] == true
          ? cancelRideOtherOptionIsSelected.value = true
          : cancelRideOtherOptionIsSelected.value = false;
    } else {
      cancelRideReasonIsSelected[5] = false;
      cancelRideReasonIsSelected[index] = !cancelRideReasonIsSelected[index];
      cancelRideOtherOptionIsSelected.value = false;
      cancelRideReasonIsSelected[index] == true
          ? cancelRideSubmitButtonIsEnabled.value = true
          : cancelRideSubmitButtonIsEnabled.value = false;
    }
  }

  cancelRideOtherOptionOnChanged(String value) {
    if (value.isEmpty) {
      cancelRideSubmitButtonIsEnabled.value = false;
      cancelRideOtherOptionIsActive.value = false;
    } else {
      cancelRideSubmitButtonIsEnabled.value = true;
      cancelRideOtherOptionIsActive.value = true;
    }
  }

  goToCancelRideDialogNextPage() {
    cancelRideDialogPageController.value.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> delayedWithPause(Duration duration) async {
    final end = DateTime.now().add(duration);
    while (DateTime.now().isBefore(end)) {
      if (rideSimulationIsStopped.value) return;
      while (rideSimulationIsPaused.value) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  //Show cancel ride dialog
  showCancelRideDialog() async {
    var size = Get.context!.size;
    var colorScheme = Theme.of(Get.context!).colorScheme;
    rideSimulationIsPaused.value = true;

    await showAdaptiveDialog(
      context: Get.context!,
      barrierColor: kDarkBackgroundColor.withOpacity(.4),
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return cancelRideDialog(
          TripScreenController.instance,
          colorScheme,
          size!,
        );
      },
    );
  }

  //Exit cancel ride dialog
  exitCancelRideDialog() {
    rideSimulationIsPaused.value = false;
    Get.close(0);
  }

  //Submit cancel ride form
  Future<void> submitCancelRideForm() async {
    if (cancelRideReasonIsSelected[5] == true) {
      if (cancelRideFormKey.currentState!.validate()) {
        cancelRideFormKey.currentState!.save();
        if (cancelRideOtherOptionEC.text.isEmpty) {
          //Show the snackbar
          DelightToastBar(
            autoDismiss: true,
            snackbarDuration: Duration(seconds: 3),
            position: DelightSnackbarPosition.bottom,
            builder: (context) => MessageAlertToast(
              title: "Warning!",
              message: "Please fill the form",
              titleColor: kWarningColor,
              leading: SvgPicture.asset(
                Assets.appIconSvg,
                width: 40,
                height: 40,
              ),
            ),
          ).show(Get.context!);
          return;
        }
        log("Selected Values: ${cancelRideOtherOptionEC.text}");
        goToCancelRideDialogNextPage();

        await Future.delayed(const Duration(seconds: 2));
        goToHomeScreen();
      }
    } else {
      List<String> selectedValues = [];
      for (int i = 0; i < cancelRideReasonIsSelected.length - 1; i++) {
        if (cancelRideReasonIsSelected[i]) {
          selectedValues.add(cancelRideReasons[i]);
        }
      }

      // Log or process the selected values
      log("Selected Values: $selectedValues");
      goToCancelRideDialogNextPage();

      await Future.delayed(const Duration(seconds: 2));
      goToHomeScreen();
    }
  }

  //==================================== Driver Rating =========================================\\

  //============= Keys =============\\
  final badRatingFormKey = GlobalKey<FormState>();

  //============= Variables =============\\
  var rating = 0.0.obs;
  var goodReasons = [
    "Safe driving",
    "Good music",
    "Clean car",
    "Polite driver",
    "Provided snacks",
  ];
  var badReasons = [
    "Rude driver",
    "Unsafe driving",
    "Dirty car",
    "Different car",
    "Arrived late",
    "Asked to cancel",
    "Requested for offline ride",
    "Others",
  ];

  //============= Booleans =============\\
  var hasRated = false.obs;
  var othersIsSelected = false.obs;
  var goodRatingFeedbackTextFieldIsActive = false.obs;
  var badRatingFeedbackTextFieldIsVisible = false.obs;
  var badRatingFeedbackTextFieldIsActive = false.obs;
  var goodReasonIsSelected = [false, false, false, false, false].obs;
  var badReasonIsSelected =
      [false, false, false, false, false, false, false, false].obs;
  var goodRateDriverButtonIsDisabled = true.obs;
  var badRateDriverButtonIsDisabled = true.obs;

  //============= Controllers =============\\
  var driverRatingPageController = PageController();
  var goodRatingFeedbackEC = TextEditingController();
  var badRatingFeedbackEC = TextEditingController();

  //============= Focus Nodes =============\\
  var goodRatingFeedbackFN = FocusNode();
  var badRatingFeedbackFN = FocusNode();

  //============= Functions =============\\
  rateDriver(int index) {
    rating.value = index + 1;
    hasRated.value = true;
  }

  void toggleGoodReasonSelection(int index) {
    goodReasonIsSelected[index] = !goodReasonIsSelected[index];
    goodRateDriverButtonIsDisabled.value =
        goodReasonIsSelected.every((isSelected) => !isSelected);

    // badRatingFeedbackTextFieldIsVisible.value = false;
    // badReasonIsSelected.value =
    // badReasonIsSelected.every((isSelected) => false);
  }

  void toggleBadReasonSelection(int index) {
    if (index == 7) {
      badReasonIsSelected[0] = false;
      badReasonIsSelected[1] = false;
      badReasonIsSelected[2] = false;
      badReasonIsSelected[3] = false;
      badReasonIsSelected[4] = false;
      badReasonIsSelected[5] = false;
      badReasonIsSelected[6] = false;
      badReasonIsSelected[7] = !badReasonIsSelected[7];
      if (badRatingFeedbackEC.text.isNotEmpty &&
          badReasonIsSelected[7] == false) {
        badRateDriverButtonIsDisabled.value = true;
      } else {
        badRateDriverButtonIsDisabled.value = false;
      }
      if (badReasonIsSelected[7] == true) {
        badRatingFeedbackTextFieldIsVisible.value = true;
      } else {
        badRatingFeedbackTextFieldIsVisible.value = false;
      }
    } else {
      badReasonIsSelected[7] = false;
      badReasonIsSelected[index] = !badReasonIsSelected[index];
      badRateDriverButtonIsDisabled.value = false;
      badRateDriverButtonIsDisabled.value =
          badReasonIsSelected.every((isSelected) => !isSelected);
      badRatingFeedbackTextFieldIsVisible.value = false;
    }
  }

  badRatingOnChanged(String value) {
    if (value.isEmpty) {
      badRateDriverButtonIsDisabled.value = true;
      badRatingFeedbackTextFieldIsActive.value = false;
    } else {
      badRatingFeedbackTextFieldIsActive.value = true;
      badRateDriverButtonIsDisabled.value = false;
    }
  }

  showDriverRatingDialog() async {
    var size = Get.context!.size;
    var colorScheme = Theme.of(Get.context!).colorScheme;

    await showAdaptiveDialog(
      context: Get.context!,
      barrierColor: kDarkBackgroundColor.withOpacity(.4),
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return driverRatingDialog(
          TripScreenController.instance,
          colorScheme,
          size!,
        );
      },
    );
  }

  //Good Rating Submit Function
  Future<void> submitGoodRating() async {
    List<String> selectedValues = [];

    for (int i = 0; i < goodReasons.length - 1; i++) {
      if (goodReasonIsSelected[i]) selectedValues.add(goodReasons[i]);
    }

    log("Rating: ${rating.value}");
    log("Selected Values: $selectedValues");

    //Show the snackbar
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: Duration(seconds: 3),
      position: DelightSnackbarPosition.bottom,
      builder: (context) => MessageAlertToast(
        title: "Feeback received",
        message: "We're glad you enjoyed the ride!",
        leading: SvgPicture.asset(
          Assets.appIconSvg,
          width: 40,
          height: 40,
        ),
      ),
    ).show(Get.context!);
    Get.close(0);

    await Future.delayed(const Duration(seconds: 2));

    goToHomeScreen();
  }

  //Bad Rating Submit Function
  Future<void> submitBadRating() async {
    if (badReasonIsSelected[7] == true) {
      if (badRatingFormKey.currentState!.validate()) {
        badRatingFormKey.currentState!.save();
        if (badRatingFeedbackEC.text.isEmpty) {
          //Show the snackbar
          DelightToastBar(
            autoDismiss: true,
            snackbarDuration: Duration(seconds: 3),
            position: DelightSnackbarPosition.bottom,
            builder: (context) => MessageAlertToast(
              title: "Warning!",
              message: "Please fill the form",
              titleColor: kWarningColor,
              leading: SvgPicture.asset(
                Assets.appIconSvg,
                width: 40,
                height: 40,
              ),
            ),
          ).show(Get.context!);
          return;
        }
        log("Selected Values: ${badRatingFeedbackEC.text}");
      }
    } else {
      List<String> selectedValues = [];

      for (int i = 0; i < badReasons.length - 1; i++) {
        if (badReasonIsSelected[i]) selectedValues.add(badReasons[i]);
      }

      // Log or process the selected values
      log("Rating: ${rating.value}");
      log("Selected Values: $selectedValues");
    }

    //Show the snackbar
    DelightToastBar(
      autoDismiss: true,
      snackbarDuration: Duration(seconds: 3),
      position: DelightSnackbarPosition.bottom,
      builder: (context) => MessageAlertToast(
        title: "Feeback received",
        message: "We sincerely apologise for the poor ride.",
        leading: SvgPicture.asset(
          Assets.appIconSvg,
          width: 40,
          height: 40,
        ),
      ),
    ).show(Get.context!);

    Get.close(0);

    await Future.delayed(const Duration(seconds: 2));

    //Navigate to the home screen
    goToHomeScreen();
  }

  Future<void> goToHomeScreen() async {
    await Get.offAll(
      () => const AndroidHomeScreen(),
      routeName: "/home",
      fullscreenDialog: true,
      curve: Curves.easeInOut,
      predicate: (routes) => false,
      popGesture: false,
      transition: Get.defaultTransition,
    );
  }
}
