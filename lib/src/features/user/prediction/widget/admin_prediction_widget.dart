import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/app_colors.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';

import 'custom_container.dart';

class VipPredictionCardWidget extends StatelessWidget {
  final void Function()? onTap;
  final String image;
  final String title;
  final String subTitle;
  final double? imageSize;
  final String predictionText;
  final Color? borderColor;

  const VipPredictionCardWidget(
      {super.key,
      this.onTap,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.predictionText,
      this.imageSize,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      borderColor: borderColor ?? AppColor.lightPinkColor.withOpacity(.5),
      borderRadius: 12,
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Image.asset(
              image,
              height: imageSize ?? 35,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme(context).bodySmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
                Text(
                  subTitle,
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: AppColor.textgreyColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 8),
                ),
              ],
            ),
            Spacer(),
            Text(
              predictionText,
              style: textTheme(context).bodySmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
