import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

import '../../../common/widgets/loginbutton.dart';
import 'add_new_user.dart';
import 'user_list.dart';

class TotalUser extends StatelessWidget {
  const TotalUser({Key? key}) : super(key: key);

  Widget _buildSubscriptionCard(String title, String percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF9E9E9E).withOpacity(0.8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColor.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color.fromARGB(89, 76, 175, 79))),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorSchemeLight.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      percentage,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Total User',
            leadingWidget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
            ),
            endWidget: SizedBox(
              width: 10,
            ),
          )),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(
                    () => UserList(
                      text: 'Active',
                    ),
                  );
                },
                child: _buildSubscriptionCard("Active Users", "300%")),
            GestureDetector(
                onTap: () {
                  Get.to(
                    () => UserList(
                      text: 'Expired',
                    ),
                  );
                },
                child: _buildSubscriptionCard("Expired Users", "5%")),
            GestureDetector(
                onTap: () {
                  Get.to(
                    () => UserList(
                      text: 'Revenue',
                    ),
                  );
                },
                child: _buildSubscriptionCard("Revenue Users", "5%")),
            const SizedBox(height: 120),
            LoginButton(
              text: 'Add New User',
              func: () {
                Get.to(
                  () => const AddNewUser(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
