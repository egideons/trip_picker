import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trip_picker/constants/consts.dart';

import 'colors.dart';

//IOS Light Theme
CupertinoThemeData? iOSLightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  applyThemeToAll: true,
  scaffoldBackgroundColor: kLightBackgroundColor,
  barBackgroundColor: kLightBackgroundColor,
  textTheme: CupertinoTextThemeData(
    textStyle: defaultTextStyle(),
  ),
);

//IOS Dark Theme
CupertinoThemeData? iOSDarkTheme = CupertinoThemeData(
  brightness: Brightness.dark,
  applyThemeToAll: true,
  scaffoldBackgroundColor: kDarkBackgroundColor,
  barBackgroundColor: kDarkBackgroundColor,
  textTheme: CupertinoTextThemeData(
    textStyle: defaultTextStyle(),
  ),
);

//Android Light Theme
ThemeData androidLightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  applyElevationOverlayColor: false,
  textTheme: TextTheme(
    titleLarge: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 30,
      fontWeight: FontWeight.w900,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    titleMedium: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 24,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    titleSmall: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    bodyLarge: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    bodyMedium: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    bodySmall: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 12,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    labelLarge: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 24,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    labelMedium: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    labelSmall: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 14,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
  ),
  // textTheme: GoogleFonts.montserratAlternatesTextTheme(Typography.dense2021),
  colorScheme: ColorScheme.light(
    surface: kLightBackgroundColor,
    primary: kPrimaryColor,
    inversePrimary: kAccentColor,
    secondary: kSecondaryColor,
    brightness: Brightness.light,
    error: Colors.red,
  ),
);

//Android Dark Theme
ThemeData androidDarkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  applyElevationOverlayColor: false,
  textTheme: TextTheme(
    titleLarge: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 36,
      fontWeight: FontWeight.w900,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    titleMedium: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    titleSmall: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    bodyLarge: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 24,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    bodyMedium: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    bodySmall: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 12,
      fontWeight: FontWeight.w500,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    labelLarge: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 30,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    labelMedium: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
    labelSmall: defaultTextStyle(
      fontFamily: "Poppins",
      fontSize: 10,
      fontWeight: FontWeight.w600,
      // overflow: TextOverflow.ellipsis,
      letterSpacing: -1.0,
    ),
  ),
  // textTheme: GoogleFonts.montserratAlternatesTextTheme(Typography.dense2021),
  colorScheme: ColorScheme.dark(
    surface: kDarkBackgroundColor,
    primary: kPrimaryColor,
    inversePrimary: kAccentColor,
    secondary: kSecondaryColor,
    brightness: Brightness.dark,
    error: Colors.red,
  ),
);
