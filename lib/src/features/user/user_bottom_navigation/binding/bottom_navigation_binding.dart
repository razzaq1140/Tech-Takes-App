import 'package:get/get.dart';

import '../controller/bottom_navigation_controller.dart';

class BottomNavigationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(() => BottomNavigationController());
  }
}
