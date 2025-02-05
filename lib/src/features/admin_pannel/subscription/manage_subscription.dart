import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';

import '../../../common/widgets/loginbutton.dart';
import 'active_subscription.dart';
import 'add_new_subscription.dart';

class ManageSubscription extends StatelessWidget {
  const ManageSubscription({Key? key}) : super(key: key);

  Widget _buildSubscriptionCard(String title, String percentage, context) {
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
            Text(title,
                style: textTheme(context).headlineMedium?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w600,
                    fontSize: 15)),
            // Circular Percentage Indicator
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //   color: Colors.green,
                  border:
                      Border.all(color: const Color.fromARGB(89, 76, 175, 79))),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(
                        0xffe0f0e4), //colorSchemeLight.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(percentage,
                        style: textTheme(context).headlineMedium?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
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
            leadingWidget: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: colorScheme(context).surface,
              ),
            ),
            title: 'Manage Subscription',
            endWidget: SizedBox(),
          )),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            GestureDetector(
                onTap: () {
                  Get.to(
                    const ActiveSubscription(
                      text: 'Active',
                    ),
                  );
                },
                child: _buildSubscriptionCard(
                    "Active\nSubscription", "300%", context)),
            GestureDetector(
                onTap: () {
                  Get.to(
                    const ActiveSubscription(
                      text: 'Expired',
                    ),
                  );
                },
                child: _buildSubscriptionCard(
                    "Expired\nSubscription", "5%", context)),
            GestureDetector(
                onTap: () {
                  Get.to(
                    const ActiveSubscription(
                      text: 'Revenue',
                    ),
                  );
                },
                child: _buildSubscriptionCard(
                    "Revenue\nSubscription", "5%", context)),
            const SizedBox(height: 120),
            LoginButton(
              text: 'Add New Subscription',
              func: () {
                Get.to(
                  AddNewSubscriptionScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
