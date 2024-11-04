import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';

homeHeader(
  HomeScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
    child: Row(
      children: [
        IconButton(
          onPressed: () {},
          // borderRadius: BorderRadius.circular(3),
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: colorScheme.surface,
            minimumSize: Size(30, 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          icon: Icon(Icons.menu),
        ),
        4.toWidth,
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: ShapeDecoration(
              color: colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    enableFeedback: true,
                    mouseCursor: SystemMouseCursors.click,
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.location5,
                          // Icons.location_on_rounded,
                          color: kGreenIconColor,
                        ),
                        10.toWidth,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "To",
                              style: defaultTextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: kTextHeaderColor,
                              ),
                            ),
                            Text(
                              "No 12, GRA, Okumgbowa street",
                              style: defaultTextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: kTextGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                20.toWidth,
                IconButton(
                  onPressed: () {},
                  // borderRadius: BorderRadius.circular(3),
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  icon: Icon(
                    Icons.add_box,
                    color: kGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
