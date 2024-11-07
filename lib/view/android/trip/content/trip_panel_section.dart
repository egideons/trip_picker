import 'package:flutter/material.dart';
import 'package:trip_picker/controllers/app/trip_screen_controller.dart';

tripPanelSection(
  TripScreenController controller,
  Size size,
  ColorScheme colorScheme,
) {
  // if (controller.panelIsOpen.value) {
  return SizedBox();
  // return Stack(
  //   clipBehavior: Clip.none,
  //   alignment: Alignment.topCenter,
  //   children: [
  //     // The container with a circular cutout at the top
  //     Container(
  //       width: size.width,
  //       decoration: ShapeDecoration(
  //         color: colorScheme.surface,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(12),
  //             topRight: Radius.circular(12),
  //           ),
  //         ),
  //       ),
  //       margin: const EdgeInsets.only(top: 40), // Space for the avatar
  //       child: ClipPath(
  //         clipper: TripContainerAvatarClipper(),
  //         child: Container(
  //           color: colorScheme.surface,
  //           alignment: Alignment.center,
  //           child: Column(
  //             children: [
  //               Text(
  //                 "Go on 10 trips and get 5gb data bonus",
  //                 textAlign: TextAlign.start,
  //                 overflow: TextOverflow.ellipsis,
  //                 maxLines: 2,
  //                 style: defaultTextStyle(
  //                   color: kTextWhiteColor,
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     // Positioned CircleAvatar
  //     Positioned(
  //       top: 0,
  //       child: circleAvatarImage(
  //         colorScheme,
  //         height: 95,
  //         foregroundImage: AssetImage(Assets.userAvatarPng),
  //       ),
  //     ),
  //   ],
  // );
  // } else {
  //   Container();
  // }
}
