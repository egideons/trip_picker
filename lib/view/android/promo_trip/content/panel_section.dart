import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/controllers/app/home_promo_screen_controller.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';

promoTripPanelSection(
  HomePromoScreenController controller,
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
          AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: ShapeDecoration(
                    color: colorScheme.inversePrimary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                  ),
                  child: () {
                    if (controller.panelBannerHasButton.value) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Go on 10 trips and get 5gb data bonus",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: defaultTextStyle(
                                color: kTextWhiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 20,
                              width: 40,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: ShapeDecoration(
                                color: colorScheme.surface,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Claim",
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: defaultTextStyle(
                                    color: colorScheme.inversePrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text(
                          "25% bonus applied on this trip",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: defaultTextStyle(
                            color: kTextWhiteColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      );
                    }
                  }())
              .animate()
              .fade(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              ),
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
                  20.toHeight,
                  SizedBox(
                    height: 80,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Assets.cabIconPng, height: 40),
                              Text(
                                "Cab",
                                textAlign: TextAlign.center,
                                style: defaultTextStyle(
                                  color: kDefaultTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Assets.logisticsIconPng, height: 40),
                              Text(
                                "Logistics",
                                textAlign: TextAlign.center,
                                style: defaultTextStyle(
                                  color: kDefaultTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Assets.cashIconSvg,
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: kGreyColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Estimated Trip Time",
                                textAlign: TextAlign.center,
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "34 mins",
                                  textAlign: TextAlign.center,
                                  style: defaultTextStyle(
                                    color: kDefaultTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.toWidth,
                        Container(
                          height: 40,
                          width: 1,
                          color: kGreyColor,
                        ),
                        10.toWidth,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Range",
                                textAlign: TextAlign.center,
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "3 miles",
                                  textAlign: TextAlign.center,
                                  style: defaultTextStyle(
                                    color: kDefaultTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.toWidth,
                        Container(
                          height: 40,
                          width: 1,
                          color: kGreyColor,
                        ),
                        10.toWidth,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Cost of Trip",
                                textAlign: TextAlign.center,
                                style: defaultTextStyle(
                                  color: kTextBlackColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "N ${FormatToType.doubleFormattedText(4700)}",
                                  textAlign: TextAlign.center,
                                  style: defaultTextStyle(
                                    color: kDefaultTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  20.toHeight,
                  Center(
                    child: SizedBox(
                      width: size.width - 100,
                      child: AndroidElevatedButton(
                        title: "Book Trip",
                        onPressed: () {},
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
