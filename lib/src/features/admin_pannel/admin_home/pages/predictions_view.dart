import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/features/admin_pannel/active_coupon/page/active_coupon.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_auth/pages/admin_login_page.dart';

import '../../subscription/manage_subscription.dart';
import '../../user/total_user.dart';
import '../../predictions/view/update_predicition.dart';

class PredictionsPage extends StatelessWidget {
  const PredictionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            endWidget: SizedBox(
              width: 20,
            ),
            title: 'App Manage',
            // leadingWidget:
            // GestureDetector(
            //     onTap: () {
            //       Get.off(const AdminLoginPage());
            //     },
            //     child: Icon(
            //       Icons.arrow_back,
            //       color: colorScheme(context).surface,
            //     )),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Get.to(const UpdatePrediction());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 19, 162, 98),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color.fromARGB(255, 19, 162, 98))),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/predictions.png',
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Update Predictions',
                                style: textTheme(context).bodyMedium?.copyWith(
                                    color: colorScheme(context).onSurface,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'Use this section to update existing sports predictions with new details or analysis.',
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: AppColor.textgreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Get.to(const ManageSubscription());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 19, 162, 98),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //   color: Colors.green,
                            border: Border.all(
                                color: const Color.fromARGB(89, 76, 175, 79))),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/allUsers.png',
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Manage Subscriptions',
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Manage user subscriptions to update access levels and monitor subscription statuses.',
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: AppColor.textgreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Get.to(const TotalUser());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(15),
                  border: Border.all(
                    color: const Color.fromARGB(255, 19, 162, 98),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color.fromARGB(89, 76, 175, 79))),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/subscription.png',
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Users',
                                style: textTheme(context).bodyMedium?.copyWith(
                                    color: colorScheme(context).onSurface,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8),
                            Text(
                              'Track real-time insights and key metrics to understand your performance and growth.',
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: AppColor.textgreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Get.to(ActiveCoupomPage());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  border: Border.all(
                    color: const Color.fromARGB(255, 19, 162, 98),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(19),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: const Color.fromARGB(89, 76, 175, 79))),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            AppImages.promoCode,
                            height: 55,
                            width: 55,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Promo Codes',
                                style: textTheme(context).bodyMedium?.copyWith(
                                    color: colorScheme(context).onSurface,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              'Track real-time insights and key metrics to understand your performance and growth',
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: AppColor.textgreyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
