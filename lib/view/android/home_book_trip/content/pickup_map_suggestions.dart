import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_book_trip_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

homeBookTripPickupMapSuggestions(
  HomeBookTripScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return Container(
    height: 400,
    decoration: ShapeDecoration(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadows: [
        BoxShadow(
          color: const Color(0xc0000000),
          blurRadius: 4,
          offset: const Offset(0, 2),
          spreadRadius: -2,
        ),
      ],
    ),
    child: Scrollbar(
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, index) => Divider(color: kGreyColor),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: controller.selectPickupSuggestion,
            dense: true,
            leading: Icon(
              Iconsax.location5,
              color: colorScheme.primary,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: size.width - 100,
                  child: Text(
                    "From ",
                    overflow: TextOverflow.ellipsis,
                    style: defaultTextStyle(
                      color: kFormFieldLabelTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width - 100,
                  child: Text(
                    controller.pickupSuggestion.value,
                    style: defaultTextStyle(
                      color: kFormFieldTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    ),
  ).animate().scale(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
}
