// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';

import 'package:tech_takes_app/src/features/user/prediction/model/prediction_model.dart';
import 'package:tech_takes_app/src/features/user/prediction/controllers/vip_pridiction_controler.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/admin_prediction_widget.dart';
import 'package:tech_takes_app/src/features/user/user_bottom_navigation/view/bottom_navigation_view.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

class PastPredictionPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PastPredictionPage({super.key});

  @override
  State<PastPredictionPage> createState() => _PastPredictionPageState();
}

class _PastPredictionPageState extends State<PastPredictionPage> {
  final VipPridictionControllers controllers =
      Get.put(VipPridictionControllers());

  bool isVipUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80),
            child: DecoratedAppBar(
                endWidget: SizedBox(
                  width: 20,
                ),
                leadingWidget: GestureDetector(
                  onTap: () {
                    Get.off(const BottomNavigationPage());
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: colorScheme(context).surface,
                  ),
                ),
                title: 'Past Prediction')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              TabBar(
                unselectedLabelColor: AppColor.tabBarGreyColor,
                indicatorColor: colorScheme(context).primary,
                labelColor: colorScheme(context).primary,
                tabs: const [
                  Tab(text: 'Past Free'),
                  Tab(text: 'Past Vip'),
                ],
              ),
              GetBuilder<VipPridictionControllers>(
                  id: 'PredictionScreen',
                  builder: (conssstext) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20),
                      child: SizedBox(
                        height: 600,
                        width: double.infinity,
                        child: TabBarView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Predictions',
                                  style: textTheme(context).bodySmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: colorScheme(context).onSurface),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: predictionList.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: VipPredictionCardWidget(
                                        borderColor:
                                            controllers.predictionIndex.value ==
                                                    index
                                                ? AppColor.appGreenColor
                                                : AppColor.lightPinkColor
                                                    .withOpacity(.5),
                                        onTap: () {
                                          controllers
                                              .predictionIndexUpdate(index);
                                        },
                                        predictionText: predictionList[index]
                                            .predictionText,
                                        image: predictionList[index].image,
                                        title: predictionList[index].title,
                                        subTitle:
                                            predictionList[index].subTitle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: predictionList.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: VipPredictionCardWidget(
                                        borderColor:
                                            controllers.predictionIndex.value ==
                                                    index
                                                ? AppColor.appGreenColor
                                                : AppColor.lightPinkColor
                                                    .withOpacity(.5),
                                        onTap: () {
                                          controllers
                                              .predictionIndexUpdate(index);
                                        },
                                        predictionText: predictionList[index]
                                            .predictionText,
                                        image: predictionList[index].image,
                                        title: predictionList[index].title,
                                        subTitle:
                                            predictionList[index].subTitle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
