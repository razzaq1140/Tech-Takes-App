import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_login_page.dart';
import 'package:tech_takes_app/src/features/get_started/selected_role_controller.dart';
import 'package:tech_takes_app/src/features/user/login/binding/login_binding.dart';

import '../../user/login/view/login_view.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  SelectedRoleController controller = Get.put(SelectedRoleController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              AppImages.logoImage,
              height: 120,
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Choose Your Role',
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 70,
            ),
            LoginButton(
                text: 'User',
                func: () {
                  Get.to(const LoginPage(), binding: LoginBinding());
                }),
            const SizedBox(
              height: 20,
            ),
            LoginButton(
                text: 'Admin',
                func: () {
                  Get.to(const AdminLoginPage());
                }),
          ],
        ),
      ),
    );
  }
}
