import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;

  // selectedIndex is no longer observable with `.obs`
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }

  void changeTab(int index) {
    selectedIndex = index;
    tabController.animateTo(index);
    update(); // Manually trigger GetBuilder to update
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
