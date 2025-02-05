import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';
import 'package:tech_takes_app/src/features/user/system_history/model/daily_result_model.dart';

class DailyResultTapPage extends StatelessWidget {
  DailyResultTapPage({super.key});

  @override
  List<String> dailyResult = [
    'Date',
    'wins',
    'losses',
    'D profit',
    'At  Profit',
  ];
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    return Column(
      children: [
        CustomContainer(
          height: m.height * 0.7,
          borderRadius: 12,
          color: AppColor.textgreyColor.withOpacity(.15),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(dailyResult.length, (index) {
                    return Text(dailyResult[index],
                        style: textTheme(context).bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context).onSurface));
                  }),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                  ),
                  child: ListView.builder(
                    itemCount: dailyResulList.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  dailyResulList[index].date,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme(context).onSurface),
                                ),
                                Text(
                                  dailyResulList[index].months,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme(context).onSurface),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 45,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  dailyResulList[index].wins,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme(context).onSurface),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 45,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  dailyResulList[index].losses,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme(context).onSurface),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: Center(
                              child: Text(
                                dailyResulList[index].dProfit,
                                style: textTheme(context).bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: dailyResulList[index]
                                            .dProfit
                                            .startsWith('-')
                                        ? colorScheme(context).error
                                        : AppColor.appGreenColor),
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            child: Center(
                              child: Text(
                                dailyResulList[index].atProfit,
                                style: textTheme(context).bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: dailyResulList[index]
                                            .atProfit
                                            .startsWith('-')
                                        ? colorScheme(context).error
                                        : AppColor.appGreenColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
