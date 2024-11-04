import 'package:get/get.dart';

class SuccessScreenController extends GetxController {
  static SuccessScreenController get instance {
    return Get.find<SuccessScreenController>();
  }

//============= Variables =============\\
  var isLoading = false.obs;

//============= Load BottomNavView =============\\
  loadHome() async {
    isLoading.value = true;

    // await UserController.instance.getUserProfile();
    await Future.delayed(const Duration(days: 2));

    // await Get.offAll(
    //   () => const AndroidHomeScreen(),
    //   routeName: "/home",
    //   fullscreenDialog: true,
    //   curve: Curves.easeInOut,
    //   predicate: (routes) => false,
    //   popGesture: false,
    //   transition: Get.defaultTransition,
    // );

    isLoading.value = true;
  }
}
