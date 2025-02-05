import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_reset_password_page.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/controller/timer_controller.dart';
import 'package:tech_takes_app/src/features/user/forgot_password/view/forgot_view.dart';

import '../../../../common/widgets/loginbutton.dart';

class AdminSendOtpPage extends StatefulWidget {
  final String? email;
  const AdminSendOtpPage({super.key, this.email});

  @override
  State<AdminSendOtpPage> createState() => _AdminSendOtpPageState();
}

class _AdminSendOtpPageState extends State<AdminSendOtpPage> {
  String otpCode = "";
  OtpFieldController otpFieldController = OtpFieldController();
  final TimerController timerController = Get.put(TimerController());

  @override
  void initState() {
    super.initState();

    timerController.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
          leading: IconButton(
              onPressed: () {
                Get.off(const ForgotPage());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Verification",
                      style: textTheme(context).headlineMedium?.copyWith(
                          fontSize: 22,
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                      "We’ve send you the verification code on ${widget.email}",
                      style: textTheme(context).bodySmall?.copyWith(
                            color: colorScheme(context).onSurface,
                          )),
                  const SizedBox(height: 140),
                  OTPTextField(
                    obscureText: true,
                    controller: otpFieldController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 75,
                    isDense: false,
                    outlineBorderRadius: 12,
                    spaceBetween: 6,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                    style: const TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceEvenly,
                    fieldStyle: FieldStyle.box,
                    onChanged: (pin) {
                      otpCode = pin;
                      log("Current PIN: $pin");
                    },
                    onCompleted: (pin) {
                      otpCode = pin;
                      log("Completed: $pin");
                    },
                  ),
                  const SizedBox(
                    height: 230,
                  ),
                  LoginButton(
                      text: 'Continue',
                      func: () {
                        if (otpCode.length == 4) {
                          Get.to(const AdminResetPasswordPage());
                        } else {
                          log("Invalid OTP: Please enter a 4-digit code.");

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter a 4-digit OTP."),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Obx(() {
                      return Text(
                          "Resend Code = 0:${timerController.start.value.toString().padLeft(2, '0')}",
                          style: textTheme(context).bodySmall?.copyWith(
                                fontSize: 13,
                                color: colorScheme(context).onSurface,
                              ));
                    }),
                  ),
                ]),
          ),
        ));
  }
}
