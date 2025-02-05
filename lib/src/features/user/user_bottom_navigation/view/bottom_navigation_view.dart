import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/user/chat_group/view/all_user.dart';
import 'package:tech_takes_app/src/features/user/chat_group/view/chatgroup_view.dart';
import 'package:tech_takes_app/src/features/user/prediction/pages/vip_prediction_page.dart';

import '../../settings/view/settings_view.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavigationPage extends GetView<BottomNavigationController> {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationController());

    List<Widget> buildScreens() {
      return [
        // ChatGroupPage(),
        GroupChatScreen(),
        VipPredictionPage(),
        SettingsPage(),
      ];
    }

    return Obx(() => WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child: Scaffold(
            body: buildScreens()[controller.selectedIndex.value],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              backgroundColor: colorScheme(context).primary,
              currentIndex: controller.selectedIndex.value,
              onTap: (index) => controller.updateIndex(index),
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SvgPicture.asset(
                      controller.selectedIndex.value == 0
                          ? AppIcons.chatRoomActiveIcon
                          : AppIcons.chatRoomInActiveIcon,
                      height: controller.selectedIndex.value == 0 ? 27 : 24,
                      width: controller.selectedIndex.value == 0 ? 27 : 24,
                    ),
                  ),
                  label: 'Chatroom',
                  backgroundColor: colorScheme(context).primary,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: SvgPicture.asset(
                      controller.selectedIndex.value == 1
                          ? AppIcons.predictionActiveIcon
                          : AppIcons.predictionInActiveIcon,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: 'Predictions',
                  backgroundColor: colorScheme(context).primary,
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SvgPicture.asset(
                      controller.selectedIndex.value == 2
                          ? AppIcons.settingActiveIcon
                          : AppIcons.settingInactiveIcon,
                      height: 25,
                      width: 25,
                    ),
                  ),
                  label: 'Settings',
                  backgroundColor: colorScheme(context).primary,
                ),
              ],
            ),
          ),
        ));
  }
}
