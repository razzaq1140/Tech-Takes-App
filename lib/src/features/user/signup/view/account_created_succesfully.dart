import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/user/login/view/login_view.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

class AccountCreatedPage extends StatefulWidget {
  const AccountCreatedPage({super.key});

  @override
  State<AccountCreatedPage> createState() => _AccountCreatedPageState();
}

class _AccountCreatedPageState extends State<AccountCreatedPage> {
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
                radius: 70,
                backgroundColor: colorScheme(context).primary,
                child: Container(
                  height: 290,
                  width: 110,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppIcons.doneIcon,
                      height: 35,
                      width: 35,
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Text("Account created \nsuccessfully",
                textAlign: TextAlign.center,
                style: textTheme(context).headlineMedium?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: 10,
            ),
            Text("You can now log in.",
                style: textTheme(context).bodySmall?.copyWith(
                      color: colorScheme(context).onSurface,
                    )),
            SizedBox(
              height: 30,
            ),
            LoginButton(
              text: 'Login',
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
