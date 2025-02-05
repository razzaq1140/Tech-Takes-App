import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class BottomNavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  void updateIndex(int index) {
    selectedIndex.value = index;
    controller.jumpToTab(index);
  }
}
