import 'package:flutter/material.dart';
import 'theme_resources.dart';

class WithingTheme {
  static WithingDefaultColors withingDefaultColors =
      const WithingDefaultColors();
  static WithingDefaultTexts withingDefaultTexts = const WithingDefaultTexts();
  static Color temporaryColor = withingDefaultColors.primaryColor;

  static ThemeData withingThemeData = ThemeData(
    // fontFamily: ,
    textTheme: withingTextTheme(
      withingDefaultColors,
      withingDefaultTexts,
    ),
    colorScheme: withingColorScheme(
      withingDefaultColors,
    ),
    canvasColor: AppColors.gray50,
    hintColor: AppColors.gray300,
    useMaterial3: true,
  );
}
