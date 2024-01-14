import 'package:flutter/material.dart';
import 'abs_theme_colors.dart';

const Color tmpColor = Colors.black;

ColorScheme withingColorScheme(WithingDefaultColors withingColors) {
  return ColorScheme(
    brightness: Brightness.light,
    background: withingColors.backgroundColor,
    primary: withingColors.primaryColor,
    primaryContainer: withingColors.primaryContainerColor,
    secondary: withingColors.subColor,
    error: withingColors.errorColor,
    outline: withingColors.lineColor,

    // 필요시 추가 할당
    surface: tmpColor,
    onBackground: tmpColor,
    onPrimary: tmpColor,
    onSecondary: tmpColor,
    onError: tmpColor,
    onSurface: tmpColor,
  );
}
