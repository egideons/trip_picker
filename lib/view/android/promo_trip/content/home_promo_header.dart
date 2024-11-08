import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_promo_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/utils/text_form_fields/android/android_textformfield.dart';

promoTripHeader(
  HomePromoScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 44),
    child: Row(
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            shadows: [
              BoxShadow(
                color: const Color(0xc0000000),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: -16,
              ),
            ],
          ),
          child: IconButton(
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
        ),
        4.toWidth,
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              left: 10,
              top: controller.headerSearchSectionIsVisible.value ? 0 : 10,
              bottom: controller.headerSearchSectionIsVisible.value ? 0 : 10,
            ),
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
            child: Row(
              children: [
                Expanded(
                  child: controller.headerSearchSectionIsVisible.value
                      ? headerSearchSection(
                          controller,
                          colorScheme,
                          size,
                        )
                      : destinationInkWell(
                          controller,
                          "No 12, GRA, Okumgbowa street",
                        ),
                ),
                controller.headerSearchSectionIsVisible.value
                    ? IconButton(
                        onPressed: () {},
                        // borderRadius: BorderRadius.circular(3),
                        style: IconButton.styleFrom(
                          backgroundColor: colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        icon: Icon(
                          Icons.add_box,
                          color: kGreyColor,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

headerSearchSection(
  HomePromoScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return Form(
    key: controller.searchFieldFormKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        4.toHeight,
        Row(
          children: [
            Icon(
              Iconsax.location5,
              color: colorScheme.primary,
            ),
            4.toWidth,
            Expanded(
              child: formFieldContainer(
                colorScheme,
                size,
                containerHeight: size.height * .05,
                padding: const EdgeInsets.only(left: 10.0),
                borderSideColor: controller.pickupFieldIsActive.value
                    ? colorScheme.primary
                    : kTransparentColor,
                borderRadius: 2,
                borderSideWidth: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    2.toHeight,
                    Text(
                      "From",
                      style: defaultTextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: kFormFieldLabelTextColor,
                      ),
                    ),
                    Expanded(
                      child: AndroidTextFormField(
                        controller: controller.pickupEC,
                        focusNode: controller.pickupFN,
                        onChanged: controller.pickupFieldOnChanged,
                        cursorHeight: 15,
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.sentences,
                        style: defaultTextStyle(
                          fontSize: 12,
                          color: kDefaultTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        labelStyle: defaultTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                    6.toHeight,
                  ],
                ),
              ),
            ),
            10.toWidth,
            // Icon(
            //   Iconsax.map5,
            //   color: controller.pickupFieldIsActive.value
            //       ? colorScheme.primary
            //       : kGreyColor,
            // ),
          ],
        ),
        4.toHeight,
        SizedBox(
          height: .2,
          width: size.width,
          child: DottedBorder(
            color: kGreyColor,
            strokeWidth: 1,
            dashPattern: [4, 2],
            child: SizedBox(
              height: 1,
              width: double.infinity,
            ),
          ),
        ),
        4.toHeight,
        Row(
          children: [
            Icon(
              Iconsax.location5,
              color: kGreenIconColor,
            ),
            4.toWidth,
            Expanded(
              child: formFieldContainer(
                colorScheme,
                size,
                containerHeight: size.height * .05,
                padding: const EdgeInsets.only(left: 10.0),
                borderSideColor: controller.destinationFieldIsActive.value
                    ? kGreenIconColor
                    : kTransparentColor,
                borderRadius: 2,
                borderSideWidth: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    2.toHeight,
                    Text(
                      "To",
                      style: defaultTextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: kFormFieldLabelTextColor,
                      ),
                    ),
                    Expanded(
                      child: AndroidTextFormField(
                        controller: controller.destinationEC,
                        focusNode: controller.destinationFN,
                        onChanged: controller.destinationFieldOnChanged,
                        cursorHeight: 15,
                        style: defaultTextStyle(
                          fontSize: 12,
                          color: kDefaultTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                        textInputAction: TextInputAction.done,
                        textCapitalization: TextCapitalization.sentences,
                        labelStyle: defaultTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ),
                    6.toHeight,
                  ],
                ),
              ),
            ),
            10.toWidth,
            // InkWell(
            //   onTap: controller.destinationFieldIsActive.value ? () {} : null,
            //   child: Icon(
            //     Iconsax.map5,
            //     color: controller.destinationFieldIsActive.value
            //         ? kGreenIconColor
            //         : kGreyColor,
            //   ),
            // ),
          ],
        ),
        4.toHeight,
      ],
    ),
  );
}

destinationInkWell(HomePromoScreenController controller, String destination) {
  return InkWell(
    onTap: controller.showHeaderSearchSection,
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "To",
                style: defaultTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: kDefaultTextColor,
                ),
              ),
              Text(
                destination,
                overflow: TextOverflow.ellipsis,
                style: defaultTextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: kTextGreyColor,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
