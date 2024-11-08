import 'package:flutter/material.dart';
import 'package:trip_picker/controllers/app/book_trip_screen_controller.dart';

import '../../../../utils/buttons/android/android_elevated_button.dart';

homeBookTripCollapsedSection(BookTripScreenController controller) {
  return Container(
    margin: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
    child: AndroidElevatedButton(
      title: "Choose Ride",
      onPressed: controller.chooseRide,
      borderRadius: 10,
    ),
  );
}
