import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/user/login/view/login_view.dart';

class PasswordChangedPage extends StatefulWidget {
  const PasswordChangedPage({super.key});

  @override
  State<PasswordChangedPage> createState() => _PasswordChangedPageState();
}

class _PasswordChangedPageState extends State<PasswordChangedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 55,
                backgroundColor: colorScheme(context).primary,
                child: Center(
                  child: SvgPicture.asset(
                    AppIcons.doneIcon,
                    height: 25,
                    width: 35,
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Congratulation your password \nhas been changed",
                style: textTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: colorScheme(context).onSurface),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            LoginButton(
              text: 'Continue',
              func: () {
                Get.to(LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
