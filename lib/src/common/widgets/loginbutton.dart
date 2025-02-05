// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/common/constants/global_variable.dart';

class LoginButton extends StatelessWidget {
  String text;
  final Widget? centerWidget;
  void Function()? func;
  BorderRadius? radius;

  LoginButton({
    Key? key,
    required this.text,
    this.centerWidget,
    this.radius =
        const BorderRadius.all(Radius.circular(16)), // Corrected default value
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: func,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: colorScheme(context).primary,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ]),
          child: Center(
              child: centerWidget ??
                  Text(text,
                      style: textTheme(context).headlineSmall?.copyWith(
                          color: colorScheme(context).surface,
                          fontSize: 18,
                          fontWeight: FontWeight.w600))),
        ));
  }
}
