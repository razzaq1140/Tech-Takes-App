import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';
import 'package:tech_takes_app/src/features/user/prediction/pages/past_predictioon.dart';

class DecoratedAppBar extends StatelessWidget {
  final Widget? leadingWidget;
  final Widget? endWidget;
  final String title;
  final double? fontSize;
  final VoidCallback? ontap;
  final Widget? text;
  final Color? textColor;

  const DecoratedAppBar(
      {super.key,
      this.leadingWidget,
      this.endWidget,
      required this.title,
      this.fontSize,
      this.ontap,
      this.textColor,
      this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.appGreenColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leadingWidget ?? SizedBox(width: 30),
            text ??
                Text(
                  title,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: textColor ?? colorScheme(context).surface,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize),
                ),
            endWidget ??
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  offset: const Offset(0, 20),
                  color: AppColor.white,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      enabled: false,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(PastPredictionPage());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 17,
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text("Past Predictions",
                                style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                    )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
