import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/user/chat_group/repository/firebase_services.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/view/forgot_view.dart';
import 'package:tech_takes_app/src/features/user/repository/firebase_auth.dart';
import 'package:tech_takes_app/src/features/user/signup/view/signup_view.dart';

import '../../../../common/strings/app_strings.dart';
import '../../user_bottom_navigation/view/bottom_navigation_view.dart';

bool passwordObsecured = false;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the PasswordVisibilityController

    TextEditingController emialController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final PasswordVisibilityController passwordVisibilityController =
        Get.put(PasswordVisibilityController());

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Text(
                  AppStrings.getStarted,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppStrings.create,
                  style: textTheme(context).bodySmall?.copyWith(
                      color: AppColor.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 110,
                ),
                Column(
                  children: [
                    LoginTextfield(
                      controller: emialController,
                      hintText: AppStrings.email,
                      sufficon: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: SvgPicture.asset(
                          AppIcons.emailIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      keyboard1: TextInputType.emailAddress,
                      validator1: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }

                        if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    LoginTextfield(
                      controller: passwordController,
                      hintText: AppStrings.password,
                      sufficon: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: SvgPicture.asset(
                          AppIcons.passwordIcon,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      texttype: passwordObsecured.toString(),
                      obscureText:
                          passwordVisibilityController.passwordObsecured.value,
                      func: (value) {
                        passwordVisibilityController.togglePasswordVisibility();
                      },
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
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ForgotPage());
                          },
                          child: Text(AppStrings.forgot,
                              style: textTheme(context).bodySmall?.copyWith(
                                  fontSize: 15,
                                  color: colorScheme(context).primary,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 200),
                Obx(() {
                  return LoginButton(
                    centerWidget:
                        passwordVisibilityController.isLoading.value == true
                            ? CircularProgressIndicator(
                                color: colorScheme(context).surface,
                              )
                            : Text(AppStrings.login,
                                style: textTheme(context)
                                    .headlineSmall
                                    ?.copyWith(
                                        color: colorScheme(context).surface,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                    text: AppStrings.login,
                    func: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        try {
                          passwordVisibilityController.isLoading.value = true;

                          final userCredential = await AuthServices.auth
                              .signInWithEmailAndPassword(
                            email: emialController.text,
                            password: passwordController.text,
                          )
                              .then((val) {
                            Get.to(() => const BottomNavigationPage());
                            print("Login successful");
                          });
                        } catch (error) {
                          print("Login failed: ${error}");
                          Get.snackbar(
                            "Teck Takes App",
                            "Failed to log in. Please check your email and password.",
                            snackPosition: SnackPosition.TOP,
                          );
                          passwordVisibilityController.isLoading.value = false;
                        }
                        passwordVisibilityController.isLoading.value = false;
                      }
                    },
                  );
                }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(AppStrings.already,
                        style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.grey,
                            )),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const SignupPage());
                      },
                      child: Text(AppStrings.signup,
                          style: textTheme(context).bodySmall?.copyWith(
                              color: colorScheme(context).primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
