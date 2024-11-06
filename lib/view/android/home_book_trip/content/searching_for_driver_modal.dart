import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_booking_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

searchingForDriverModal(
  HomeBookTripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  return Obx(
    () {
      return Container(
        width: size.width,
        decoration: ShapeDecoration(
          color: colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SpinKitThreeInOut(
                itemBuilder: (context, index) {
                  return Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: kLightGreyColor,
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              10.toHeight,
              controller.bookDriverFound.value
                  ? Text(
                      "Driver found",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      "Searching for a Driver",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              10.toHeight,
              controller.bookDriverFound.value
                  ? Text(
                      "Arriving in 6 minutes",
                      textAlign: TextAlign.start,
                      style: defaultTextStyle(
                        color: kTextGreyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : SizedBox(),
              controller.bookDriverFound.value ? 10.toHeight : 0.toHeight,
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: kTrackColor),
                  ),
                ),
                child: LinearProgressIndicator(
                  value: controller.progress.value,
                  minHeight: 3,
                  borderRadius: BorderRadius.circular(30),
                  backgroundColor: kTrackColor,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(colorScheme.primary),
                ),
              ),
              20.toHeight,
            ],
          ),
        ),
      );
    },
  );
}
