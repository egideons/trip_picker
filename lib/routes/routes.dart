import 'package:get/get.dart';
import 'package:trip_picker/view/android/auth/login_signup/android_login_signup_screen.dart';
import 'package:trip_picker/view/android/auth/verify_email_otp/android_verify_email_otp_screen.dart';
import 'package:trip_picker/view/android/auth/verify_phone_otp/android_verify_phone_otp_screen.dart';
import 'package:trip_picker/view/android/home_promo/android_home_promo_screen.dart';
import 'package:trip_picker/view/android/onboarding/android_onboarding_screen.dart';
import 'package:trip_picker/view/android/splash_screen/startup/android_startup_screen.dart';
import 'package:trip_picker/view/android/splash_screen/success/android_success_screen.dart';
import 'package:trip_picker/view/android/trip/android_trip_screen.dart';

class Routes {
  //Splash screens
  static const startupSplashscreen = "/";
  static const congratulationsSplashScreen = "/congratulations-splash";
  static const loadingScreen = "/loading";
  static const successScreen = "/success-screen";

  static const onboarding = "/onboarding";
  static const loginSignup = "/login-signup";
  static const verifyPhoneOtp = "/verify-phone-otp";
  static const verifyEmailOtp = "/verify-email-otp";

  static const homePromo = "/home-promo";
  static const homeBookTrip = "/home-book-trip";
  static const trip = "/trip";

  //========================= GET PAGES ==========================\\
  static final getPages = [
    //Startup and Auth
    GetPage(name: startupSplashscreen, page: () => AndroidStartupScreen()),
    GetPage(name: onboarding, page: () => AndroidOnboardingScreen()),
    GetPage(name: loginSignup, page: () => AndroidLoginSignupScreen()),
    GetPage(name: verifyPhoneOtp, page: () => AndroidVerifyPhoneOtpScreen()),
    GetPage(name: verifyEmailOtp, page: () => AndroidVerifyEmailOtpScreen()),
    GetPage(name: successScreen, page: () => AndroidSuccessScreen()),

    GetPage(name: homePromo, page: () => AndroidHomePromoScreen()),
    GetPage(name: homeBookTrip, page: () => AndroidHomePromoScreen()),
    GetPage(name: trip, page: () => AndroidTripScreen()),
  ];
}
