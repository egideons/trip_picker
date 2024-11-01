import 'package:get/get.dart';

class LoginSignupController extends GetxController {
  static LoginSignupController get instance {
    return Get.find<LoginSignupController>();
  }

  var currentPage = 0.obs;
  var isLoginPage = true.obs;
  var isLoading = false.obs;

  selectLoginPage() {
    isLoginPage.value = true;
  }

  selectSignupPage() {
    isLoginPage.value = false;
  }
}
