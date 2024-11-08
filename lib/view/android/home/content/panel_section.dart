import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/containers/form_field_container.dart';
import 'package:trip_picker/view/android/home/content/panel_banner_section.dart';

homePanelSection(
  HomeScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  if (controller.panelIsOpen.value) {
    return Container(
      decoration: ShapeDecoration(
        color: colorScheme.inversePrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
      child: Column(
        children: [
          // controller.panelBannerIsVisible.value
          //     ?
          panelBannerSection(colorScheme, controller),
          // : SizedBox(),
          Expanded(
            child: AnimatedContainer(
              width: size.width,
              padding: const EdgeInsets.all(10),
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              decoration: ShapeDecoration(
                color: colorScheme.surface,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.toHeight,
                  optionsSection(controller, colorScheme),
                  20.toHeight,
                  controller.panelCabDestinationTextFieldIsVisible.value
                      ? panelCabDestination(controller, colorScheme, size)
                      : SizedBox(),
                  20.toHeight,
                  Center(
                    child: SizedBox(
                      width: size.width - 100,
                      child: controller.goToLogisticsButtonIsVisible.value
                          ? AndroidElevatedButton(
                              title: "Go to Logistics",
                              onPressed: controller.goToLogistics,
                              borderRadius: 10,
                              minimumSize: Size(size.width, 60),
                            )
                          : AndroidElevatedButton(
                              title: "Book Trip",
                              onPressed: controller.bookCabTrip,
                              disable: !controller.readyToBookTrip.value,
                              borderRadius: 10,
                              minimumSize: Size(size.width, 60),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return SizedBox();
  }
}

panelCabDestination(
  HomeScreenController controller,
  ColorScheme colorScheme,
  Size size,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: formFieldContainer(
      colorScheme,
      size,
      color: kSearchContainerColor.withOpacity(.6),
      containerHeight: size.height * .064,
      padding: const EdgeInsets.all(0),
      borderSideColor: kTransparentColor,
      borderSideWidth: 0,
      child: ListTile(
        onTap: controller.showHeaderSearchSection,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Icon(Iconsax.search_normal),
        ),
        minVerticalPadding: 4,
        dense: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "To",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: defaultTextStyle(
                color: kDefaultTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            Text(
              controller.panelDestination.value,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: defaultTextStyle(
                color: kTextGreyColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

optionsSection(
  HomeScreenController controller,
  ColorScheme colorScheme,
) {
  return Row(
    children: List.generate(
      controller.options.length,
      (index) {
        var cab = controller.options[index];
        return Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: ShapeDecoration(
            color: controller.selectedOptionIndex.value == index
                ? kAccentColor.withOpacity(.1)
                : kTransparentColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: IconButton(
            onPressed: () {
              controller.selectOption(index);
            },
            icon: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(cab["icon"] ?? Assets.placeholderImage, height: 40),
                Text(
                  cab["name"] ?? "",
                  textAlign: TextAlign.center,
                  style: defaultTextStyle(
                    color: controller.selectedOptionIndex.value == index
                        ? kAccentColor
                        : kDefaultTextColor,
                    fontSize: 12,
                    fontWeight: controller.selectedOptionIndex.value == index
                        ? FontWeight.w800
                        : FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

// Padding(
//   padding: const EdgeInsets.only(left: 20.0),
//   child: Text(
//     "Distance",
//     textAlign: TextAlign.start,
//     style: defaultTextStyle(
//       color: colorScheme.primary,
//       fontSize: 12,
//       fontWeight: FontWeight.w600,
//     ),
//   ),
// ),
// Obx(
//   () => Expanded(
//     child: Stack(
//       alignment: Alignment.centerLeft,
//       children: [
//         Container(
//           width: double.infinity,
//           height: 1,
//           color: kTrackColor,
//         ),
//         Positioned(
//           left: controller.thumbPosition.value,
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 800),
//             curve: Curves.easeIn,
//             width: 20.0,
//             height: 20.0,
//             decoration: BoxDecoration(
//               color: colorScheme.primary,
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: kLightBackgroundColor,
//                 width: 2.0,
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     Text(
//       controller.displayDistance.value,
//       textAlign: TextAlign.start,
//       style: defaultTextStyle(
//         color: kTextGreyColor,
//         fontSize: 9,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     Text(
//       '50mi',
//       textAlign: TextAlign.start,
//       style: defaultTextStyle(
//         color: kTextGreyColor,
//         fontSize: 9,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//   ],
// ),
