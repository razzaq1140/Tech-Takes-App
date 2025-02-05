import 'package:get/get.dart';

class PasswordVisibilityController extends GetxController {
  var passwordObsecured = true.obs;
  var confirmPasswordObsecured = true.obs;

  void togglePasswordVisibility() {
    passwordObsecured.value = !passwordObsecured.value;
  }

  void toggleConfirmPasswordVisibility() {
    confirmPasswordObsecured.value = !confirmPasswordObsecured.value;
  }

  RxBool isLoading = false.obs;
}
