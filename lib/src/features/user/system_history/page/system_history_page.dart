// ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/common/widgets/custom_appbar.dart';
import 'package:tech_takes_app/src/common/widgets/vip_prediction_app_bar.dart';
import 'package:tech_takes_app/src/features/user/discount_promo/page/promo_screen.dart';
import 'package:tech_takes_app/src/features/user/prediction/pages/vip_prediction_page.dart';
import 'package:tech_takes_app/src/features/user/system_history/model/daily_result_model.dart';
import 'package:tech_takes_app/src/features/user/system_history/widget/daily_result_widget.dart';

import '../../prediction/widget/custom_container.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';

class SystemHistoryPage extends StatelessWidget {
  SystemHistoryPage({super.key});

  @override
  List<String> weeksName = ['TUE', 'WEB', ''];
  Widget build(BuildContext context) {
    final List<String> weeksName = [
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
      'MON'
    ];
    final List<List<String>> dailyValues = [
      ["0.42", "5 x 12", "48 x 50", "0.42", "-2", "4.29", "-4.04"],
      ["0.13", "-0.52", "4.29", "0.13", "-2", "4.29", "-4.04"],
      ["0.42", "1", "5 x 12", "0.42", "-2", "4.29", "-4.04"],
    ];

    var m = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 80),
            child: DecoratedAppBar(
              title: 'System History',
              endWidget: SizedBox(),
              leadingWidget: GestureDetector(
                  onTap: () {
                    Get.off(VipPredictionPage());
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: colorScheme(context).surface,
                  )),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: colorScheme(context).primary,
                unselectedLabelColor: AppColor.tabBarGreyColor,
                labelColor: colorScheme(context).primary,
                tabs: const [
                  Tab(text: 'Daily Result'),
                  Tab(text: 'Full history'),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  children: [
                    DailyResultTapPage(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'SYSTEM HISTORY',
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  'OCT',
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Spacer(),
                                Text(
                                  '2024',
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomContainer(
                              onTap: () {
                                Get.to(PromoScreen());
                              },
                              borderRadius: 12,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              color: AppColor.textgreyColor.withOpacity(.15),
                              child: Center(
                                child: Text(
                                  'PAST SUMMARY',
                                  style: textTheme(context)
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomContainer(
                              borderRadius: 12,
                              color: AppColor.textgreyColor.withOpacity(.15),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: List.generate(
                                      previousDataList.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 10.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            previousDataList[index].amount,
                                            style: textTheme(context)
                                                .bodySmall
                                                ?.copyWith(
                                                  color: colorScheme(context)
                                                      .onSurface,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            color: index == 0
                                                ? AppColor.textgreyColor
                                                : AppColor.appGreenColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 5),
                                            child: Text(
                                              previousDataList[index].totalText,
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme(context)
                                                              .onSurface,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            CustomContainer(
                              borderRadius: 12,
                              color: AppColor.textgreyColor.withOpacity(.15),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: weeksName
                                          .map((day) => Text(day,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)))
                                          .toList(),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 150,
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7,
                                          mainAxisSpacing: 4,
                                          crossAxisSpacing: 4,
                                          childAspectRatio:
                                              1.0, // Adjust ratio if needed
                                        ),
                                        itemCount: weeksName.length *
                                            dailyValues.length,
                                        itemBuilder: (context, index) {
                                          int row = index ~/ weeksName.length;
                                          int column = index % weeksName.length;
                                          String value =
                                              dailyValues[row][column];
                                          bool isPositive =
                                              !value.contains('-');
                                          Color boxColor = isPositive
                                              ? Colors.green
                                              : Colors.red;

                                          return Container(
                                            // height: 70,
                                            decoration: BoxDecoration(
                                              color: boxColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1),
                                            ),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: SizedBox(
                                                width: 32,
                                                child: Text(
                                                  value,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // textAlign: TextAlign.end,
                                                  style: TextStyle(
                                                    color: AppColor
                                                        .systemHistoryText,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            CustomContainer(
                              borderRadius: 12,
                              color: AppColor.textgreyColor.withOpacity(.15),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'curent month profit/loss',
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: AppColor.appGreenColor),
                                      child: Center(
                                        child: Text(
                                          '17.9',
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor
                                                      .systemHistoryText),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 280,
                              child: AspectRatio(
                                aspectRatio: 1.2,
                                child: LineChart(
                                  LineChartData(
                                    minX: 0,
                                    maxX: 4,
                                    minY: 0,
                                    maxY: 50,
                                    titlesData: FlTitlesData(
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 10,
                                          getTitlesWidget: (value, _) {
                                            return Text(
                                              value.toInt().toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 12),
                                            );
                                          },
                                        ),
                                      ),
                                      // bottomTitles: AxisTitles(
                                      //   sideTitles: SideTitles(
                                      //     showTitles: true,
                                      //     getTitlesWidget: (value, _) {
                                      //       switch (value.toInt()) {
                                      //         case 0:
                                      //           return const Text('Jan',
                                      //               style: TextStyle(
                                      //                   color: Colors.grey));

                                      //         case 1:
                                      //           return const Text('Feb',
                                      //               style: TextStyle(
                                      //                   color: Colors.grey));
                                      //         case 2:
                                      //           return const Text('Mar',
                                      //               style: TextStyle(
                                      //                   fontWeight:
                                      //                       FontWeight.bold,
                                      //                   color: Colors.black));
                                      //         case 3:
                                      //           return const Text('Apr',
                                      //               style: TextStyle(
                                      //                   color: Colors.grey));
                                      //         case 4:
                                      //           return const Text('Jan',
                                      //               style: TextStyle(
                                      //                   color: Colors.grey));

                                      //         default:
                                      //           return Container();
                                      //       }
                                      //     },
                                      //   ),
                                      // ),

                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval:
                                              1, // Ensures each value on the x-axis shows a unique label
                                          getTitlesWidget: (value, _) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return const Text('Jan',
                                                    style: TextStyle(
                                                        color: Colors.grey));
                                              case 1:
                                                return const Text('Feb',
                                                    style: TextStyle(
                                                        color: Colors.grey));
                                              case 2:
                                                return const Text('Mar',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black));
                                              case 3:
                                                return const Text('Apr',
                                                    style: TextStyle(
                                                        color: Colors.grey));
                                              case 4:
                                                return const Text('May',
                                                    style: TextStyle(
                                                        color: Colors.grey));
                                              default:
                                                return Container();
                                            }
                                          },
                                        ),
                                      ),

                                      rightTitles: const AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      topTitles: const AxisTitles(
                                        axisNameSize: 24,
                                        axisNameWidget: Padding(
                                          padding: EdgeInsets.only(bottom: 04),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('22 JULY 2024',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                              Text('29 OCT 2024',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                        sideTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                    ),
                                    /*gridData: FlGridData(
                                        show: true,
                                        drawVerticalLine: false,
                                        getDrawingHorizontalLine: (value) {
                                          return FlLine(
                                            color: Colors.grey[300],
                                            strokeWidth: 1,
                                          );
                                        },
                                      ),*/
                                    lineBarsData: [
                                      LineChartBarData(
                                        isCurved: true,
                                        color: Colors.green,
                                        barWidth: 2,
                                        belowBarData: BarAreaData(show: false),
                                        spots: [
                                          const FlSpot(0, 8),
                                          const FlSpot(1, 12),
                                          const FlSpot(2, 22),
                                          const FlSpot(3, 18),
                                          const FlSpot(4, 28),
                                        ],
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter:
                                              (spot, percent, bar, index) {
                                            if (spot.x == 2) {
                                              return FlDotCirclePainter(
                                                radius: 4,
                                                color: Colors.green,
                                                strokeWidth: 2,
                                                strokeColor: Colors.white,
                                              );
                                            }
                                            return FlDotCirclePainter(
                                                radius: 0); // Hide other dots
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
