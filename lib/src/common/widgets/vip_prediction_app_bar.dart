import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tech_takes_app/src/common/constants/app_images.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';

class VipPredictionAppbar extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Widget? leadingWidget;
  final double? textSize;
  final void Function()? onTap;
  const VipPredictionAppbar(
      {super.key,
      required this.text,
      this.textColor,
      this.textSize,
      this.onTap,
      this.leadingWidget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap ,
            child: leadingWidget ??
                SvgPicture.asset(
                  AppIcons.backIcon,
                  height: 30,
                ),
          ),
          Text(
            text,
            style: textTheme(context).titleLarge?.copyWith(
                color: textColor ?? colorScheme(context).onSurface,
                fontSize: textSize ?? 18,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
