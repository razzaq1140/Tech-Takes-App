import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/get_started/selected_role_controller.dart';

import '../../../../common/strings/app_strings.dart';
import '../../login/binding/login_binding.dart';
import '../../login/view/login_view.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();

  final adminNameController = TextEditingController();
  final adminPhoneController = TextEditingController();
  final adminEmailController = TextEditingController();
  final adminPasswordController = TextEditingController();
  final adminBioController = TextEditingController();

  var selectedImagePath = ''.obs;
  final formKey = GlobalKey<FormState>();
  final onlyAlphaPattern = RegExp(r'^[a-z A-Z,.\-]+$');

  final onlypasswPattern =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-])');
  final onlyemailPattern = RegExp(r"\w+@\w+\,\w+");
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      await uploadImage(File(pickedFile.path));
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  RxString uploadedImageUrl = ''.obs;
  Future<void> uploadImage(File file) async {
    // Reference to Firebase Storage
    FirebaseStorage storage = FirebaseStorage.instance;
    String fileName =
        'images/${DateTime.now().millisecondsSinceEpoch}.jpg'; // Unique file name

    // Create a reference to the file location in Firebase Storage
    Reference reference = storage.ref().child(fileName);

    try {
      // Upload the file to Firebase Storage
      TaskSnapshot snapshot = await reference.putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Store the download URL in the observable
      uploadedImageUrl.value = downloadUrl;
      Get.snackbar("Success", "Image uploaded successfully!");

      log("Image uploaded successfully! Download URL: $downloadUrl");
    } on FirebaseException catch (e) {
      Get.snackbar("Error", "Failed to upload image: ${e.message}");
      log('Error uploading image: $e');
    }
  }

  Future<bool> validateAndLogin(context) async {
    if (SelectedRoleController.to.selectedRoles.value == true
        ? adminNameController.text.isEmpty
        : nameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty",
        backgroundColor: AppColor.white.withOpacity(0.8),
        snackStyle: SnackStyle.FLOATING,
        barBlur: 0,
        colorText: AppColor.black,
      );
      return false;
    } else if (SelectedRoleController.to.selectedRoles.value == true
        ? adminPhoneController.text.isEmpty
        : phoneController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Phone Number cannot be empty",
        backgroundColor: colorScheme(context).primary.withOpacity(0.4),
        snackStyle: SnackStyle.FLOATING,
        barBlur: 3,
        colorText: AppColor.black,
      );
      return false;
    } else if (SelectedRoleController.to.selectedRoles.value == true
        ? adminEmailController.text.isEmpty
        : emailController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email cannot be empty",
        backgroundColor: colorScheme(context).primary.withOpacity(0.4),
        snackStyle: SnackStyle.FLOATING,
        barBlur: 3,
        colorText: AppColor.black,
      );
      return false;
    } else if (SelectedRoleController.to.selectedRoles.value == true
        ? !adminEmailController.text.isEmail
        : !emailController.text.isEmail) {
      Get.snackbar(
        "Error",
        "Email is not valid",
        backgroundColor: colorScheme(context).primary.withOpacity(0.4),
        snackStyle: SnackStyle.FLOATING,
        barBlur: 3,
        colorText: AppColor.black,
      );
      return false;
    } else if (SelectedRoleController.to.selectedRoles.value == true
        ? adminPasswordController.text.isEmpty
        : passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Required field",
        backgroundColor: colorScheme(context).primary.withOpacity(0.4),
        snackStyle: SnackStyle.FLOATING,
        barBlur: 3,
        colorText: AppColor.black,
      );
      return false;
    } else if (!onlypasswPattern.hasMatch(
        SelectedRoleController.to.selectedRoles.value == true
            ? adminPasswordController.text
            : passwordController.text)) {
      Get.snackbar(
        "Error",
        "Please enter one special character and digit",
        backgroundColor: colorScheme(context).primary.withOpacity(0.4),
        snackStyle: SnackStyle.FLOATING,
        barBlur: 3,
        colorText: AppColor.black,
      );
      return false;
    } else {
      Get.to(() => const LoginPage(), binding: LoginBinding());
      return true;
    }
  }

  showSignupAlertDialog(context) {
    Get.defaultDialog(
      title: "Alert Dialog",
      middleText: AppStrings.account,
      buttonColor: colorScheme(context).primary,
      textConfirm: AppStrings.ok,
      confirmTextColor: AppColor.white,
      backgroundColor: AppColor.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
