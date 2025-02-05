import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/loginbutton.dart';
import 'package:tech_takes_app/src/features/user/prediction/controllers/vip_pridiction_controler.dart';
import 'package:tech_takes_app/src/features/user/prediction/model/prediction_model.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/admin_prediction_widget.dart';
import 'package:tech_takes_app/src/features/user/system_history/page/system_history_page.dart';

class VipPredictionPage extends StatefulWidget {
  VipPredictionPage({super.key});

  @override
  State<VipPredictionPage> createState() => _VipPredictionPageState();
}

class _VipPredictionPageState extends State<VipPredictionPage> {
  final VipPridictionControllers controllers =
      Get.put(VipPridictionControllers());

  bool isVipUnlocked = false;

  @override
  Widget build(BuildContext context) {
    void showUnlockDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: colorScheme(context).primary, width: 2)),
              height: 250,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Unlock this prediction by subscribing!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isVipUnlocked = true;
                      });
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 24,
                      ),
                    ),
                    child: const Text(
                      'Subscribe Now',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 80),
          child: DecoratedAppBar(
            title: 'Predictions',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: AppColor.tabBarGreyColor,
                dividerColor: AppColor.grey.withOpacity(.5),
                indicatorColor: colorScheme(context).primary,
                labelColor: colorScheme(context).primary,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                tabs: const [
                  Tab(
                    text: 'Free Users',
                  ),
                  Tab(text: 'VIP USERS'),
                ],
                onTap: (index) {
                  if (index == 1 && !isVipUnlocked) {
                    showUnlockDialog();
                  }
                },
              ),
              GetBuilder<VipPridictionControllers>(
                  id: 'PredictionScreen',
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20),
                      child: SizedBox(
                        height: 500,
                        width: double.infinity,
                        child: TabBarView(
                          children: [
                            SizedBox(
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
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
                                      controllers.predictionIndexUpdate(index);
                                    },
                                    predictionText:
                                        predictionList[index].predictionText,
                                    image: predictionList[index].image,
                                    title: predictionList[index].title,
                                    subTitle: predictionList[index].subTitle,
                                  ),
                                ),
                              ),
                            ),
                            if (isVipUnlocked)
                              SizedBox(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
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
                                      predictionText:
                                          predictionList[index].predictionText,
                                      image: predictionList[index].image,
                                      title: predictionList[index].title,
                                      subTitle: predictionList[index].subTitle,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Please unlock VIP to access this content.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.appGreenColor,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: LoginButton(
                  text: 'View system History',
                  func: () {
                    Get.to(SystemHistoryPage());
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class DialogShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Starting from the top-left corner
    path.lineTo(0, size.height);

    // First point (left side)
    path.lineTo(size.width * 0.25, size.height - 20); // Small dip
    path.lineTo(size.width * 0.35, size.height);

    // Second point (center)
    path.lineTo(size.width * 0.5, size.height - 20); // Small dip
    path.lineTo(size.width * 0.65, size.height);

    // Third point (right side)
    path.lineTo(size.width * 0.75, size.height - 20); // Small dip
    path.lineTo(size.width, size.height);

    // Closing the path
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}*/
