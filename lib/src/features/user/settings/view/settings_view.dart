// ignore_for_file: sort_child_properties_last

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/features/get_started/pages/role_selection_page.dart';
import 'package:tech_takes_app/src/features/user/login/view/login_view.dart';
import 'package:tech_takes_app/src/features/user/settings/view/update_profile_page.dart';

import '../controller/settings_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    final settingsController = Get.put(SettingsController());

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Settings',
            endWidget: SizedBox(),
            leadingWidget: SizedBox(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Get.offAll(
                  () => const UpdateProfilePage(),
                );
              },
              child: _buildSettingsOption(
                  title: 'Profile',
                  context: context,
                  verticalPadding: 14,
                  switchWidget: SizedBox()),
            ),
            const SizedBox(height: 15),
            _buildDarkModeOption(settingsController, context),
            const SizedBox(height: 15),
            _buildSettingsOption(
                title: 'General',
                context: context,
                verticalPadding: 14,
                switchWidget: SizedBox()),
            const SizedBox(height: 15),
            GestureDetector(
                onTap: () {
                  // Get.offAll(
                  //   () => NotificationsPage(),
                  // );
                },
                child: _buildSettingsOption(
                    title: 'Notifications',
                    context: context,
                    verticalPadding: 0,
                    switchWidget: Obx(() {
                      return Switch(
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        inactiveThumbColor: Colors.grey,
                        value: controller.notificationToogle.value,
                        inactiveTrackColor: Colors.grey.withOpacity(0.4),
                        onChanged: controller.notificationToogleUpdate,
                        activeColor: colorScheme(context).primary,
                      );
                    }))),
            const SizedBox(height: 15),
            GestureDetector(
                onTap: () {
                  _showLogoutDialog(context);
                },
                child: _buildSettingsOption(
                    title: 'Log Out',
                    context: context,
                    verticalPadding: 14,
                    switchWidget: SizedBox())),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(
      {required String title,
      required context,
      required double verticalPadding,
      required Widget switchWidget}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding:
          EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(title,
              style: textTheme(context).bodySmall?.copyWith(
                  fontSize: 13,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600)),
          Spacer(),
          switchWidget,
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget _buildDarkModeOption(SettingsController controller, context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Enable Dark Mode',
              style: textTheme(context).bodySmall?.copyWith(
                  fontSize: 13,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600)),
          Obx(() => Switch(
                thumbColor: MaterialStateProperty.all(Colors.white),
                inactiveThumbColor: Colors.grey,
                value: controller.isDarkModeEnabled.value,
                inactiveTrackColor: Colors.grey.withOpacity(0.4),
                onChanged: controller.toggleDarkMode,
                activeColor: colorScheme(context).primary,
              )),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black45,
      builder: (BuildContext buildContext) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.9, // Full width
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            decorationColor: Colors.transparent,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Avatar with Logout Image
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Image.asset(
                    AppImages.logoutImage,
                    height: 35,
                    width: 35,
                  ),
                ),
                const SizedBox(height: 20),

                // Dialog Text
                Text(
                  'Are you sure you want \nto log out?',
                  style: TextStyle(
                    fontSize: 17,
                    decorationColor: Colors.transparent,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Action Buttons (Cancel and Yes, Log Out)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            decorationColor: Colors.transparent,
                            fontSize: 12,
                            color: colorScheme(context).primary),
                      ),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.green),
                        fixedSize: const Size(150, 50),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                        _showSuccessDialog(context);
                      },
                      child: const Text(
                        'Yes, Log out',
                        style: TextStyle(
                            decorationColor: Colors.transparent,
                            fontSize: 12,
                            color: AppColor.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        fixedSize: const Size(150, 50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 16,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context);
                    },
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: colorScheme(context).primary,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Icon(Icons.thumb_up,
                  size: 90, color: colorScheme(context).primary),
              const SizedBox(height: 10),
              const Text(
                'You have successfully logged\ out.',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((onValue) {
                    Navigator.pop(context); // Close the dialog
                    _showSuccessDialog(context);
                    Get.offAll(const RoleSelectionPage());

                    log('User Has Successfully logout');
                  });
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, color: AppColor.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme(context).primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  fixedSize: const Size(290, 50),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
