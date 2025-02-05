import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_forgot_password_page.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_signup_page.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_home/pages/predictions_view.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';

import '../../../../common/strings/app_strings.dart';

bool passwordObsecured = false;

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the PasswordVisibilityController
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
                    // Email textField
                    LoginTextfield(
                      hintText: AppStrings.email,
                      sufficon: Icon(Icons.email),
                      texttype: TextInputType.emailAddress.toString(),
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
                    // Password textfield
                    LoginTextfield(
                      hintText: AppStrings.password,
                      sufficon: Icon(Icons.lock),
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
                      obscureText:
                          passwordVisibilityController.passwordObsecured.value,
                      func: (value) {
                        passwordVisibilityController.togglePasswordVisibility();
                      },
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const AdminForgotPasswordPage());
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
                LoginButton(
                  text: AppStrings.login,
                  func: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Get.to(const PredictionsPage());
                    }
                  },
                ),
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
                        Get.to(() => AdminSignUpPage());
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
