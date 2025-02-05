import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_password_changed_page.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/password_visiblity_controller.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/view/verification_code.dart';

import '../../../../common/strings/app_strings.dart';

class AdminResetPasswordPage extends StatefulWidget {
  const AdminResetPasswordPage({super.key});

  @override
  State<AdminResetPasswordPage> createState() => _AdminResetPasswordPageState();
}

class _AdminResetPasswordPageState extends State<AdminResetPasswordPage> {
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final PasswordVisibilityController controller =
      Get.put(PasswordVisibilityController());

  // Function to check if new password and confirm password match
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPassword.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Get.off(const VerificationPage());
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Reset your password",
                  style: textTheme(context).headlineMedium?.copyWith(
                      fontSize: 22,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "At least 8 characters, with uppercase\nand lowercase letters",
                  style: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(.5),
                      ),
                ),
                const SizedBox(height: 110),
                Obx(() {
                  return LoginTextfield(
                    controller: newPassword,
                    hintText: AppStrings.newpass,
                    sufficon: IconButton(
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                      icon: Icon(
                        controller.passwordObsecured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.grey,
                      ),
                    ),
                    isPassword: true,
                    validator1: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 8) {
                        return 'Password should be at least 8 characters';
                      }
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Password must contain at least one lowercase letter';
                      }

                      return null;
                    },
                  );
                }),
                const SizedBox(height: 15),
                Obx(() {
                  return LoginTextfield(
                    controller: confirmPassword,
                    hintText: AppStrings.confirm,
                    sufficon: IconButton(
                      onPressed: () {
                        controller.toggleConfirmPasswordVisibility();
                      },
                      icon: Icon(
                        controller.confirmPasswordObsecured.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.grey,
                      ),
                    ),
                    isPassword: true,
                    validator1: _validateConfirmPassword,
                  );
                }),
                const SizedBox(
                  height: 170,
                ),
                LoginButton(
                  text: AppStrings.save,
                  func: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Get.to(
                        const AdminPasswordChangedPage(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
