import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/features/get_started/pages/role_selection_page.dart';
import 'package:tech_takes_app/src/features/user/repository/firebase_auth.dart';
import 'package:tech_takes_app/src/features/user/user_bottom_navigation/view/bottom_navigation_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      if (AuthServices.auth.currentUser != null) {
        Get.to(const BottomNavigationPage());
      } else {
        Get.to(const RoleSelectionPage());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColor.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(AppImages.appLogo)),
            ],
          ),
        ));
  }
}
