import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:trip_picker/controllers/auth/onboarding_controller.dart';
import 'package:trip_picker/models/onboard_model.dart';

imageSection(OnboardingController controller, OnboardModel onboardItem) {
  return controller.currentPage.value + 1 ==
          controller.onboardContent.value.items.length
      ? Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.4,
                    colors: [
                      Color(0xFFFFD700).withOpacity(.8),
                      Color(0xFFFFFFFF).withOpacity(.8),
                    ],
                  ),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 70,
                sigmaY: 70,
              ),
              child: Obx(
                () {
                  return controller.shouldAnimate.value
                      ? Image.asset(onboardItem.image)
                          .animate(
                            autoPlay: controller.shouldAnimate.value,
                          )
                          .moveY(
                            begin: controller.shouldAnimate.value ? 60 : 0,
                            end: controller.shouldAnimate.value ? -200 : 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(seconds: 2),
                          )
                          .fadeIn(
                            begin: 0,
                            curve: Curves.easeInOut,
                            duration: const Duration(seconds: 1),
                          )
                      : Image.asset(onboardItem.image);
                },
              ),
            ),
          ],
        )
      : Stack(
          children: [
            controller.currentPage.value + 1 ==
                    controller.onboardContent.value.items.length - 2
                ? SvgPicture.asset(
                    onboardItem.imageBackground,
                    height: 400,
                    width: 400,
                  )
                : SvgPicture.asset(onboardItem.imageBackground),
            controller.currentPage.value + 1 ==
                    controller.onboardContent.value.items.length
                ? Image.asset(onboardItem.image)
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                      autoPlay: true,
                    )
                    .moveY(
                      begin: 60,
                      end: -200,
                      curve: Curves.easeInOut,
                      duration: Duration(seconds: 2),
                    )
                    .fadeIn(
                      begin: 0,
                      curve: Curves.easeInOut,
                      duration: Duration(seconds: 1),
                    )
                : controller.currentPage.value + 1 ==
                        controller.onboardContent.value.items.length - 1
                    ? Image.asset(onboardItem.image)
                        .animate(
                          onPlay: (controller) => controller.repeat(),
                          autoPlay: true,
                        )
                        .shimmer(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 1000),
                        )
                    : controller.currentPage.value + 1 ==
                            controller.onboardContent.value.items.length - 2
                        ? Image.asset(
                            onboardItem.image,
                            height: 400,
                            width: 400,
                          )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                              autoPlay: true,
                            )
                            .fadeIn(
                              curve: Curves.easeInOut,
                              duration: Duration(milliseconds: 1000),
                            )
                            .fadeOut(
                              curve: Curves.easeInOut,
                              duration: Duration(seconds: 3),
                            )
                        : controller.currentPage.value + 1 ==
                                controller.onboardContent.value.items.length - 3
                            ? Image.asset(onboardItem.image)
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                  autoPlay: true,
                                )
                                .shake(
                                  curve: Curves.easeInOut,
                                  duration: Duration(seconds: 2),
                                  delay: Duration(seconds: 2),
                                )
                            : Image.asset(onboardItem.image)
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                  autoPlay: true,
                                )
                                .rotate(
                                  begin: 5,
                                  end: 0,
                                  curve: Curves.easeInOut,
                                  duration: Duration(seconds: 2),
                                  delay: Duration(milliseconds: 800),
                                ),
          ],
        ).animate(autoPlay: true).moveX(
            begin: 100,
            end: 0,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 1000),
          );
}
