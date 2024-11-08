import 'package:flutter/material.dart';
import 'package:trip_picker/controllers/app/home_book_trip_screen_controller.dart';

import '../../../../utils/buttons/android/android_elevated_button.dart';

homeBookTripCollapsedSection(HomeBookTripScreenController controller) {
  return Container(
    margin: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
    child: AndroidElevatedButton(
      title: "Select Location",
      onPressed: controller.selectLocation,
      borderRadius: 10,
    ),
  );
}
