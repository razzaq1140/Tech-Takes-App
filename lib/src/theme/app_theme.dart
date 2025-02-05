import 'package:flutter/material.dart';
import 'package:tech_takes_app/src/theme/app_color_scheme.dart';
import 'package:tech_takes_app/src/theme/app_text_theme.dart';
// import 'package:tech_takes_app/src/theme/app_color_scheme.dart';
// import 'package:tech_takes_app/src/theme/app_text_theme.dart';

class AppTheme {
  AppTheme._();

  factory AppTheme() {
    return instance;
  }

  static final AppTheme instance = AppTheme._();

  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorSchemeLight,
      textTheme: appTextTheme,
    );
  }
}
