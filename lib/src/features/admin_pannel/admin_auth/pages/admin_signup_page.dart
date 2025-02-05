import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/checkbox.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_login_page.dart';
import 'package:tech_takes_app/src/features/user/signup/controller/signup_controller.dart';

import '../../../../common/constants/app_images.dart';
import '../../../../common/strings/app_strings.dart';
import '../../../user/login/binding/login_binding.dart';
import '../../../user/login/view/login_view.dart';

bool passwordObsecured = false;

class AdminSignUpPage extends GetView<SignupController> {
  const AdminSignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    AppStrings.getStarted,
                    style: textTheme(context).titleMedium?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    AppStrings.create,
                    style: textTheme(context).bodySmall?.copyWith(
                        color: AppColor.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(
                          () => CircleAvatar(
                            radius: 60,
                            backgroundImage: controller
                                    .selectedImagePath.value.isNotEmpty
                                ? FileImage(
                                    File(controller.selectedImagePath.value))
                                : const AssetImage(AppImages.profile)
                                    as ImageProvider, // Placeholder image
                            backgroundColor: Colors.grey[300],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: colorScheme(context).primary,
                              radius: 18,
                              child: const Icon(
                                Icons.edit_square,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Name TextField with validation
                  LoginTextfield(
                    controller: controller.adminNameController,
                    hintText: AppStrings.name,
                    keyboard1: TextInputType.name,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null; // No error
                    },
                  ),
                  const SizedBox(height: 15),
                  // Phone TextField with validation
                  LoginTextfield(
                    controller: controller.adminPhoneController,
                    hintText: AppStrings.phone,
                    keyboard1: TextInputType.phone,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  // Email TextField with validation
                  LoginTextfield(
                    controller: controller.adminEmailController,
                    hintText: AppStrings.email,
                    keyboard1: TextInputType.emailAddress,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  // Password TextField with validation
                  LoginTextfield(
                    controller: controller.adminPasswordController,
                    hintText: AppStrings.password,
                    keyboard1: TextInputType.visiblePassword,
                    texttype: passwordObsecured.toString(),
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 8) {
                        return 'Password should be at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  LoginTextfield(
                    hintText: AppStrings.bio,
                    keyboard1: TextInputType.multiline,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bio is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CheckBox(),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 280,
                        child: Text('${AppStrings.check} ${AppStrings.check1}',
                            style: textTheme(context).bodySmall?.copyWith(
                                color: AppColor.grey,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  LoginButton(
                    text: AppStrings.signup,
                    radius: BorderRadius.circular(30),
                    func: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Get.to(const AdminLoginPage());
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(left: 51.0),
                    child: Row(
                      children: [
                        Text(AppStrings.already,
                            style: textTheme(context).bodySmall?.copyWith(
                                  color: AppColor.grey,
                                )),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const LoginPage(),
                                binding: LoginBinding());
                          },
                          child: Text(AppStrings.login,
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).primary,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
