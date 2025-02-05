import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VipPridictionControllers extends GetxController {
  RxInt predictionIndex = 0.obs;
  void predictionIndexUpdate(index) {
    predictionIndex.value = index;
    update(['PredictionScreen']);
    // notifyListeners();
  }

  RxInt getDiscountIndex = 0.obs;

  void updateDiscountIndex(index) {
    getDiscountIndex.value = index;
  }

  RxBool continueButton = false.obs;
  void continueUpdate(val) {
    continueButton.value = val;
  }

  int selectedIndex = 0;

  final List<String> titles = ['Active Coupons', 'Recently Used'];
  void changeTab(int index) {
    selectedIndex = index;
  }

  late TabController tabController;
  RxInt tabbarIndex = 0.obs;
}
