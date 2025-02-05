import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/checkbox.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/user/model/user_model.dart';
import 'package:tech_takes_app/src/features/user/repository/firebase_auth.dart';
import 'package:tech_takes_app/src/features/user/signup/view/account_created_succesfully.dart';

import '../../../../common/constants/app_images.dart';
import '../../../../common/strings/app_strings.dart';
import '../../login/binding/login_binding.dart';
import '../../login/view/login_view.dart';
import '../controller/signup_controller.dart';

bool passwordObsecured = false;

class SignupPage extends GetView<SignupController> {
  const SignupPage({super.key});

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
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppStrings.create,
                    style: textTheme(context).bodySmall?.copyWith(
                        color: AppColor.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
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
                                    as ImageProvider,
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
                  LoginTextfield(
                    controller: controller.nameController,
                    hintText: AppStrings.name,
                    keyboard1: TextInputType.name,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  LoginTextfield(
                    controller: controller.phoneController,
                    hintText: AppStrings.phone,
                    keyboard1: TextInputType.phone,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  LoginTextfield(
                    controller: controller.emailController,
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
                  LoginTextfield(
                    controller: controller.passwordController,
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
                    controller: controller.bioController,
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
                  Obx(() {
                    return LoginButton(
                      text: '',
                      centerWidget: controller.isLoading.value == true
                          ? CircularProgressIndicator(
                              color: colorScheme(context).surface,
                            )
                          : Text(AppStrings.signup,
                              style: textTheme(context).headlineSmall?.copyWith(
                                  color: colorScheme(context).surface,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                      func: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            final email = controller.emailController.text;
                            final password = controller.passwordController.text;

                            await AuthServices.userSignUp(
                              email,
                              password,
                            ).then((_) async {
                              controller.isLoading.value = true;
                              final currentUser = AuthServices.auth.currentUser;
                              if (currentUser != null) {
                                final name = controller.nameController.text;
                                await currentUser.updateDisplayName(name);
                                UserModel usersModel = UserModel(
                                    name: name,
                                    email: email,
                                    id: currentUser.uid,
                                    photoURL: currentUser.photoURL ?? '',
                                    bio: controller.bioController.text);
                                await AuthServices.firestore
                                    .collection("users")
                                    .doc(currentUser.uid)
                                    .set(usersModel.toMap());

                                Get.to(() => const AccountCreatedPage());
                                log('DatA Upload ');

                                log('User data saved: ${currentUser.uid}, $name, ${currentUser.email}, ${currentUser.photoURL}');
                              }
                            });
                          } catch (e) {
                            print('Error saving user data: $e');
                          }

                          controller.isLoading.value = false;
                        }
                        controller.isLoading.value = false;
                      },
                    );
                  }),
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
