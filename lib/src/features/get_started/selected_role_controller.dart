import 'package:get/get.dart';

class SelectedRoleController extends GetxController {
  static SelectedRoleController get to => Get.find();
  RxBool selectedRoles = false.obs;
  void getUserRole(role) {
    selectedRoles.value = role;
  }
}
