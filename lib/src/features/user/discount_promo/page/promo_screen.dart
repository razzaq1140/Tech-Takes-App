// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/custom_button.dart';
import 'package:tech_takes_app/src/common/widgets/vip_prediction_app_bar.dart';
import 'package:tech_takes_app/src/features/user/discount_promo/widget/discount_widget.dart';
import 'package:tech_takes_app/src/features/user/prediction/controllers/vip_pridiction_controler.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';
import 'package:tech_takes_app/src/features/user/system_history/page/system_history_page.dart';
import 'package:tech_takes_app/src/features/user/user_bottom_navigation/view/bottom_navigation_view.dart';

class PromoScreen extends StatelessWidget {
  PromoScreen({super.key});
  final VipPridictionControllers controller =
      Get.put(VipPridictionControllers());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.continueUpdate(false);

        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80),
            child: DecoratedAppBar(
              title: 'Promo',
              endWidget: SizedBox(),
              leadingWidget: GestureDetector(
                  onTap: () {
                    controller.continueUpdate(false);
                    Get.off(SystemHistoryPage());
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: colorScheme(context).surface,
                  )),
            )),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                AppImages.coupn,
                height: 125,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: colorScheme(context).surface,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(41)),
                    border: Border(
                        top: BorderSide(color: AppColor.lightPinkColor))),
                child: Obx(
                  () => controller.continueButton.value == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: CustomContainer(
                                    onTap: () {},
                                    height: 90,
                                    borderRadius: 9,
                                    color: const Color(0xffF4F2F2),
                                    borderColor: AppColor.lightPinkColor,
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 40),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: 'Congratulation',
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color:
                                                        AppColor.appGreenColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                  ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '  you have\nsuccessfully add your coupon',
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color:
                                                        AppColor.appGreenColor,
                                                    fontSize: 14,
                                                  ),
                                            ),
                                          ]),
                                        ),
                                        const Spacer(),
                                        CircleAvatar(
                                            radius: 22,
                                            child: Center(
                                                child: Text(
                                              '10%',
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme(context)
                                                              .onSurface,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            )),
                                            backgroundColor: Colors.blueAccent
                                                .withOpacity(.08)),
                                        const SizedBox(
                                          width: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: -20,
                                  child: Transform.rotate(
                                    angle: -1.57,
                                    child: Container(
                                      width: 90,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(9),
                                          topLeft: Radius.circular(9),
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffED3333),
                                            Color(0xff871D1D)
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '10% OFF',
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .surface,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: CustomButton(
                                label: 'Continue',
                                borderRadius: 16,
                                onPressed: () {
                                  Get.offAll(const BottomNavigationPage());
                                },
                                color: AppColor.appGreenColor,
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Get 10% Discount',
                              style: textTheme(context).titleMedium?.copyWith(
                                  fontSize: 22,
                                  color: AppColor.appGreenColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Column(
                              children: List.generate(3, (index) {
                                return Obx(
                                  () => Container(
                                    height: 80,
                                    child: DiscountWidget(
                                      onTap: () {
                                        controller.updateDiscountIndex(index);
                                        log(controller.getDiscountIndex
                                            .toString());
                                      },
                                      applyWidget: controller
                                                  .getDiscountIndex.value ==
                                              index
                                          ? CustomContainer(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              borderRadius: 100,
                                              color: AppColor.appGreenColor,
                                              child: Text(
                                                'Apply',
                                                style: textTheme(context)
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color:
                                                          colorScheme(context)
                                                              .surface,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            )
                                          : const SizedBox(),
                                      tickWidget: Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          color: controller
                                                      .getDiscountIndex.value ==
                                                  index
                                              ? Color(0xffCFAAAA)
                                              : Color(0xffD9D9D9),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColor.lightPinkColor),
                                        ),
                                        child:
                                            controller.getDiscountIndex.value ==
                                                    index
                                                ? Icon(
                                                    Icons.check,
                                                    size: 15,
                                                    color: colorScheme(context)
                                                        .surface,
                                                  )
                                                : SizedBox(),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Total Discount:',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '\$8',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: CustomButton(
                                label: 'Get Discount',
                                borderRadius: 16,
                                onPressed: () {
                                  controller.continueUpdate(true);
                                },
                                color: AppColor.appGreenColor,
                              ),
                            )
                          ],
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
