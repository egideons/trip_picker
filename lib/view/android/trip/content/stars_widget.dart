import 'package:flutter/material.dart';
import 'package:trip_picker/theme/colors.dart';

starsWidget(ColorScheme colorScheme, int star) {
  return Builder(
    builder: (context) {
      List<Widget> stars = [];
      for (var i = 0; i < 5; i++) {
        if (i < star) {
          stars.add(
            Icon(
              Icons.star,
              color: kStarColor,
              size: 20,
            ),
          );
        } else {
          stars.add(
            Icon(
              Icons.star,
              color: kLightGreyColor,
              size: 20,
            ),
          );
        }
      }
      return Row(children: stars);
    },
  );
}
