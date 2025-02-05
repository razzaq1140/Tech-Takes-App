import 'package:get/get.dart';

class SettingsController extends GetxController {
  var isDarkModeEnabled = false.obs;

  void toggleDarkMode(bool value) {
    isDarkModeEnabled.value = value;
  }

  RxBool notificationToogle = false.obs;

  void notificationToogleUpdate(bool value) {
    notificationToogle.value = value;
  }
}
