import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance {
    return Get.find<HomeScreenController>();
  }

//============= Variables =============\\
  var isLoading = false.obs;
}
