import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';

import '../../../../common/widgets/loginbutton.dart';
import 'add_new_predictions.dart';

class UpdatePrediction extends StatefulWidget {
  const UpdatePrediction({super.key});

  @override
  _UpdatePredictionState createState() => _UpdatePredictionState();
}

class _UpdatePredictionState extends State<UpdatePrediction>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  List<Prediction> activePredictions = [
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/red.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/red.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/red.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    // Add more items as needed
  ];

  List<Prediction> recentlyAddedPredictions = [
    Prediction(
      teamInfo: "NY +150",
      matchInfo: "NY @ MIA",
      time: "6:00pm",
      units: "3u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/red.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/red.png", // Replace with actual image path
    ),
    Prediction(
      teamInfo: "BOS +110",
      matchInfo: "BOS @ TOR",
      time: "4:00pm",
      units: "4u",
      imageUrl: "assets/images/blue.png", // Replace with actual image path
    ),
    // Add more items as needed
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(115),
        child: Column(
          children: [
            DecoratedAppBar(
              title: 'Update Predictions',
              leadingWidget: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: colorScheme(context).surface,
                  )),
              endWidget: const SizedBox(
                width: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: _buildTab("Active prediction", 0, context)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTab("Recently added", 1, context)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        children: [
          _buildPredictionList(activePredictions, context),
          _buildPredictionList(recentlyAddedPredictions, context),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index, context) {
    bool isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
        _pageController.jumpToPage(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 19, 162, 98)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Text(title,
              style: textTheme(context).bodySmall?.copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildPredictionList(List<Prediction> predictions, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    final prediction = predictions[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8), // Set padding to control vertical gap
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color.fromARGB(199, 158, 158, 158)),
                          color: Colors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              prediction.imageUrl,
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prediction.teamInfo,
                                    style: textTheme(context)
                                        .bodyMedium
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${prediction.matchInfo} - ${prediction.time}",
                                    style: textTheme(context)
                                        .bodyMedium
                                        ?.copyWith(
                                            color: AppColor.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9, right: 10),
                              child: Text(
                                prediction.units,
                                style: textTheme(context).bodyMedium?.copyWith(
                                    color: colorScheme(context).onSurface,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                LoginButton(
                  text: 'Add New Prediction',
                  func: () {
                    Get.to(() => const AddNewPredictionScreen());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Prediction {
  final String teamInfo;
  final String matchInfo;
  final String time;
  final String units;
  final String imageUrl;

  Prediction({
    required this.teamInfo,
    required this.matchInfo,
    required this.time,
    required this.units,
    required this.imageUrl,
  });
}
