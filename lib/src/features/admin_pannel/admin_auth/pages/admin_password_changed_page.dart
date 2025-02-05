import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_login_page.dart';

class AdminPasswordChangedPage extends StatefulWidget {
  const AdminPasswordChangedPage({super.key});

  @override
  State<AdminPasswordChangedPage> createState() =>
      _AdminPasswordChangedPageState();
}

class _AdminPasswordChangedPageState extends State<AdminPasswordChangedPage> {
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
              radius: 50,
              backgroundColor: colorScheme(context).primary,
              child: Center(
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Congratulation your password\n has been changed",
              textAlign: TextAlign.center,
              style: textTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: colorScheme(context).onSurface),
            ),
            SizedBox(
              height: 60,
            ),
            LoginButton(
              text: 'Continue',
              radius: BorderRadius.circular(30),
              func: () {
                Get.offAll(const AdminLoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}
