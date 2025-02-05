import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/custom_button.dart';

import 'package:tech_takes_app/src/common/widgets/vip_prediction_app_bar.dart';
import 'package:tech_takes_app/src/features/admin_pannel/active_coupon/model/active_coupen_model.dart';
import 'package:tech_takes_app/src/features/admin_pannel/active_coupon/widget/active_coupon_widget.dart';
import 'package:tech_takes_app/src/features/admin_pannel/active_coupon/widget/recently_used_coupon.dart';
import 'package:tech_takes_app/src/features/admin_pannel/add_new_coupon/admin_add_coupon_page.dart';
import 'package:tech_takes_app/src/features/admin_pannel/admin_home/pages/predictions_view.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

import '../../../user/prediction/controllers/vip_pridiction_controler.dart';

class ActiveCoupomPage extends StatefulWidget {
  ActiveCoupomPage({super.key});

  @override
  State<ActiveCoupomPage> createState() => _ActiveCoupomPageState();
}

class _ActiveCoupomPageState extends State<ActiveCoupomPage>
    with SingleTickerProviderStateMixin {
  final VipPridictionControllers controller =
      Get.put(VipPridictionControllers());

  @override
  void initState() {
    // TODO: implement initState
    controller.tabController = TabController(length: 2, vsync: this);
    controller.tabController.addListener(() {
      controller.tabbarIndex.value =
          controller.tabController.index; // Update observable index
    });

    super.initState();
  }

  void dispose() {
    controller.tabController.dispose(); // Dispose the TabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80),
            child: DecoratedAppBar(
              title: '',
              endWidget: SizedBox(),
              leadingWidget: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              text: Obx(() {
                return Text(
                  controller.tabbarIndex.value == 0
                      ? 'Active Coupons'
                      : 'Recently Used',
                  style: textTheme(context).titleMedium?.copyWith(
                        color: colorScheme(context).surface,
                        fontWeight: FontWeight.bold,
                      ),
                );
              }),
            )
            // Obx(() => VipPredictionAppbar(
            //       text: controller.tabbarIndex.value == 0
            //           ? 'Active Coupons'
            //           : 'Recently Used',
            //       onTap: () {
            //         Get.off(PredictionsPage());
            //       },
            //     )),
            ),

        // Column(
        //   children: [
        //     TabBar(
        //       controller: controller.tabController,
        //       physics: NeverScrollableScrollPhysics(),
        //       dividerColor: Colors.transparent,
        //       indicatorColor: Colors.transparent,
        //       labelColor: AppColor.green,
        //       unselectedLabelColor: Colors.grey,
        //       onTap: (index) {
        //         controller.tabController
        //             .animateTo(index, duration: Duration.zero);
        //         // controller.changeTabIndex(index);
        //         // provider.changeTab(index);
        //       },
        //       tabs: [
        //         Text(
        //           'Active Coupon',
        //         ),
        //         Text(
        //           'Recently Used ',
        //         ),
        //       ],
        //     ),
        //     Expanded(
        //       child:
        //           TabBarView(controller: controller.tabController, children: [
        //         Column(
        //           children: [
        //             SizedBox(
        //               height: 20,
        //             ),
        //             Expanded(
        //               child: ListView.builder(
        //   preferredSize: const Size(double.infinity, 90),
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 40.0),
        //     child: Consumer<VipPridictionProvider>(
        //       builder: (context, value, child) => VipPredictionAppbar(
        //         text: value.currentTitle,
        //         onTap: () {
        //           Get.off(const PredictionsPage());
        //         },
        //       ),
        //     ),
        //   ),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBar(
                controller: controller.tabController,
                physics: const NeverScrollableScrollPhysics(),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                labelColor: colorSchemeLight.primary,
                unselectedLabelColor: Colors.black,
                onTap: (index) {
                  controller.tabController
                      .animateTo(index, duration: Duration.zero);
                },
                tabs: const [
                  Text(
                    'Active Coupon',
                  ),
                  Text(
                    'Recently Used ',
                  ),
                ],
              ),
              Expanded(
                child:
                    TabBarView(controller: controller.tabController, children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: activeCouponList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 100,
                              child: ActiveCouponWidget(
                                  sidePercent:
                                      activeCouponList[index].sidePercent,
                                  headText: activeCouponList[index].headText,
                                  bottomText:
                                      activeCouponList[index].bottomText,
                                  startDate: activeCouponList[index].startDate,
                                  lastDate: activeCouponList[index].lastDate,
                                  circlePercent:
                                      activeCouponList[index].circlePercent,
                                  onTap: () {}),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 30),
                        child: CustomButton(
                          label: 'Add New Coupon ',
                          borderRadius: 16,
                          onPressed: () {
                            Get.to(AdminAddCouponPage());
                          },
                          color: AppColor.appGreenColor,
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => UserProfileCard(
                          name: 'Jerome Bell, ',
                          email: 'Jeromebell@gmail.com',
                          isOnline: true,
                          imageUrl: AppImages.userImage),
                    ),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
