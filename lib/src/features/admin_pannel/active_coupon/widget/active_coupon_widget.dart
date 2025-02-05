import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';

import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';

class ActiveCouponWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String sidePercent;
  final String headText;
  final String bottomText;
  final String startDate;
  final String lastDate;
  final String circlePercent;

  ActiveCouponWidget(
      {super.key,
      required this.sidePercent,
      required this.headText,
      required this.bottomText,
      required this.startDate,
      required this.lastDate,
      required this.circlePercent,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft, // Align elements to the left
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomContainer(
              onTap: () => onTap,
              height: 90,
              borderRadius: 9,
              color: Color(0xffF4F2F2),
              borderColor: Color(0xff91AA91),
              child: Row(
                children: [
                  SizedBox(width: 40),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        headText,
                        style: textTheme(context).bodySmall?.copyWith(
                            fontSize: 14,
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          bottomText,
                          style: textTheme(context).bodySmall?.copyWith(
                              fontSize: 10,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(.4),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            startDate,
                            style: textTheme(context).bodySmall?.copyWith(
                                fontSize: 10,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(.4),
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'To',
                            style: textTheme(context).bodySmall?.copyWith(
                                fontSize: 10,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(.4),
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            lastDate,
                            style: textTheme(context).bodySmall?.copyWith(
                                fontSize: 10,
                                color: colorScheme(context)
                                    .onSurface
                                    .withOpacity(.4),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                      radius: 22,
                      child: Center(
                          child: Text(
                        '${circlePercent}%',
                        style: textTheme(context).bodySmall?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w600),
                      )),
                      backgroundColor: Colors.blueAccent.withOpacity(.08)),
                  SizedBox(
                    width: 25,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            // Position the rotated text specifically
            left: -20, // Adjust as needed to align with the left side
            child: Transform.rotate(
              angle: -1.57, // Rotate -90 degrees
              child: Container(
                width: 90,
                height: 20, // Adjust the height to fit the rotated text
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(9),
                    topLeft: Radius.circular(9),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xffED3333), Color(0xff871D1D)],
                  ),
                ),
                child: Center(
                  child: Text(
                    '${sidePercent}% OFF',
                    style: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).surface,
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
    );
  }
}
