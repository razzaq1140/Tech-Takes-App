import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/user/repository/firebase_auth.dart';

import '../../login/view/login_view.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  TextEditingController emailController = TextEditingController();
  final password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? validateEmail(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    // Regular expression for validating an email
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);

    // Check if the value matches the pattern
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    // If everything is fine, return null (no error)
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
                Get.off(const LoginPage());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Reset Password",
                    style: textTheme(context).headlineMedium?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).onSurface),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Select which contact details should we use to reset your password",
                      style: textTheme(context)
                          .bodySmall
                          ?.copyWith(color: colorScheme(context).onSurface)),
                  const SizedBox(height: 29),
                  // _contactOption(
                  //   onTap: () {},
                  //   context: context,
                  //   icon: Icons.sms_outlined,
                  //   title: 'Email',
                  //   contact: 'A Verification code will be send to your email',
                  // ),

                  LoginTextfield(
                    controller: emailController,
                    preIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(
                        height: 17,
                        width: 17,
                        AppIcons.emailIcon,
                        color: Colors.black,
                      ),
                    ),
                    hintSize: 12,
                    validator1: validateEmail,
                    hintText1: 'Email',
                    hintText: 'A Verification code will be send to your email',
                  ),
                  const Spacer(),
                  LoginButton(
                      text: 'Continue',
                      func: () {
                        if (_formkey.currentState!.validate()) {
                          AuthServices.auth
                              .sendPasswordResetEmail(
                                  email: emailController.text.toString())
                              .then((onValue) {
                            // Show dialog after the email is sent
                            Get.dialog(
                              AlertDialog(
                                title: Text('Password Reset Link Sent'),
                                content: Text(
                                    'A password reset link has been sent to your email. Please check your inbox (or spam folder) for further instructions.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Get.back();
                                      // Navigate to the verification page
                                      Get.to(() => LoginPage());
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }).catchError((error) {
                            // Handle error (optional)
                            print('Error sending reset email: $error');
                          });
                        }
                      }),
                ]),
          ),
        ));
  }

  Widget _contactOption({
    required BuildContext context,
    IconData? icon,
    String? title,
    String? contact,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme(context).primary.withOpacity(0.03),
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(color: colorScheme(context).primary.withOpacity(0.6)),
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  height: 17,
                  width: 17,
                  AppIcons.emailIcon,
                  color: Colors.black,
                )
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title!,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontWeight: FontWeight.w400)),
                const SizedBox(height: 4),
                Text(contact!,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.9),
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
