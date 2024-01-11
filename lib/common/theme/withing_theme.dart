import 'package:flutter/material.dart';
import 'color/abs_theme_colors.dart';
import 'color/color_scheme.dart';
import 'text/abs_theme_texts.dart';
import 'text/text_scheme.dart';

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
    useMaterial3: true,
  );
}
