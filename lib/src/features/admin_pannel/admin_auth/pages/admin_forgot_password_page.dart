import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/common/widgets/textformfield_widget.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_send_otp_page.dart';

import '../../../user/login/view/login_view.dart';

class AdminForgotPasswordPage extends StatefulWidget {
  const AdminForgotPasswordPage({super.key});

  @override
  State<AdminForgotPasswordPage> createState() =>
      _AdminForgotPasswordPageState();
}

class _AdminForgotPasswordPageState extends State<AdminForgotPasswordPage> {
  final email = TextEditingController();
  final password = TextEditingController();
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

  TextEditingController emailController = TextEditingController();

  @override
  final _formkey = GlobalKey<FormState>();
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
                  Spacer(),
                  LoginButton(
                      text: 'Continue',
                      func: () {
                        if (_formkey.currentState!.validate()) {
                          Get.to(AdminSendOtpPage(
                            email: emailController.text,
                          ));
                        }
                      }),
                ]),
          ),
        ));
  }

//   Widget _contactOption({
//     required BuildContext context,
//     IconData? icon,
//     String? title,
//     String? contact,
//     required VoidCallback onTap,
//   }) {
//     String? validateEmail(String? value) {
//       // Check if the value is empty
//       if (value == null || value.isEmpty) {
//         return 'Please enter an email';
//       }

//       // Regular expression for validating an email
//       const String emailPattern =
//           r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//       final RegExp regex = RegExp(emailPattern);

//       // Check if the value matches the pattern
//       if (!regex.hasMatch(value)) {
//         return 'Please enter a valid email';
//       }

//       // If everything is fine, return null (no error)
//       return null;
//     }

//     TextEditingController emailController = TextEditingController();
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 80,
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: colorScheme(context).primary.withOpacity(0.03),
//           borderRadius: BorderRadius.circular(15),
//           border:
//               Border.all(color: colorScheme(context).primary.withOpacity(0.6)),
//         ),
//         child: Row(
//           children: [

//              LoginTextfield(
//               controller: emailController,
//               preIcon: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: SvgPicture.asset(
//                   height: 17,
//                   width: 17,
//                   AppIcons.emailIcon,
//                   color: Colors.black,
//                 ),
//               ),
//               hintSize: 12,
//               validator1: validateEmail,
//               hintText1: 'Email',
//               hintText: 'A Verification code will be send to your email',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}
