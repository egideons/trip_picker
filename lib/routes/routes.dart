import 'package:get/get.dart';
import 'package:trip_picker/app/android/onboarding/android_onboarding_screen.dart';
import 'package:trip_picker/app/android/splash_screen/startup/android_startup_screen.dart';

class Routes {
  //Splash screens
  static const startupSplashscreen = "/";
  static const congratulationsSplashScreen = "/congratulations-splash";
  static const successSplashScreen = "/success-splash";
  static const loadingScreen = "/loading";
  static const successScreen = "/success-screen";

  static const onboarding = "/onboarding";

  //========================= GET PAGES ==========================\\
  static final getPages = [
    GetPage(name: startupSplashscreen, page: () => AndroidStartupScreen()),
    GetPage(name: onboarding, page: () => AndroidOnboardingScreen())
  ];
}
