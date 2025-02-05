import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/user/prediction/widget/custom_container.dart';

class DiscountWidget extends StatelessWidget {
  final String? leftDiscount;
  final String? centerDiscount;
  final String? cofoodText;
  final Widget? tickWidget;
  final Widget? applyWidget;
  final void Function()? onTap;

  const DiscountWidget(
      {super.key,
      this.leftDiscount,
      this.centerDiscount,
      this.cofoodText,
      this.tickWidget,
      this.applyWidget,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerLeft, // Align elements to the left
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomContainer(
              onTap: onTap,
              height: 70,
              borderRadius: 9,
              color: Color(0xffF4F2F2),
              borderColor: AppColor.lightPinkColor,
              child: Row(
                children: [
                  SizedBox(width: 30),
                  tickWidget ??
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.lightPinkColor),
                        ),
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: colorScheme(context).surface,
                        ),
                      ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the text vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align text to the left
                    children: [
                      Text(
                        centerDiscount ?? '10% Discount',
                        style: textTheme(context).bodySmall?.copyWith(
                              color: colorScheme(context).onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Text(
                        cofoodText ?? 'COF000',
                        style: textTheme(context).bodySmall?.copyWith(
                              color: AppColor.appGreenColor,
                              fontSize: 9,
                            ),
                      ),
                    ],
                  ),
                  Spacer(),
                  applyWidget ??
                      CustomContainer(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        borderRadius: 100,
                        color: AppColor.appGreenColor,
                        child: Text(
                          'Apply',
                          style: textTheme(context).bodySmall?.copyWith(
                                color: colorScheme(context).surface,
                                fontSize: 12,
                              ),
                        ),
                      ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
          ),
          Positioned(
           
            left: -10,
            child: Transform.rotate(
              angle: -1.57, 
              child: Container(
                width: 70,
                height: 20, 
                decoration: const BoxDecoration(
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
                    leftDiscount ?? '10% OFF',
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
