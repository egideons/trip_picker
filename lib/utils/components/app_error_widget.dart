import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_picker/constants/consts.dart';
import 'package:trip_picker/theme/colors.dart';
import 'package:trip_picker/utils/buttons/android/android_elevated_button.dart';
import 'package:trip_picker/utils/buttons/ios/cupertino_elevated_button.dart';
import 'package:get/get.dart';

class AppErrorWidget extends StatelessWidget {
  final Function()? onPressed;
  const AppErrorWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    if (Platform.isAndroid) {
      Material(
        color: colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                size: 200,
                color: kWarningColor,
              ),
              20.toHeight,
              20.toHeight,
              const Text(
                'Oops..something unexpected happened.',
                maxLines: 4,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.toHeight,
              AndroidElevatedButton(
                onPressed: onPressed ??
                    () {
                      Get.close(0);
                    },
                title: "Go back",
              ),
            ],
          ),
        ),
      );
    }
    return Material(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              size: 200,
              color: kWarningColor,
            ),
            20.toHeight,
            20.toHeight,
            const Text(
              'Oops..something unexpected happened.',
              maxLines: 4,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.toHeight,
            CupertinoElevatedButton(
              onPressed: onPressed ??
                  () {
                    Get.close(0);
                  },
              title: "Go back",
            ),
          ],
        ),
      ),
    );
  }
}
