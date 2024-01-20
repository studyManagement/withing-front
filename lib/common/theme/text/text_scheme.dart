import 'package:flutter/material.dart';
import '../color/abs_theme_colors.dart';
import 'abs_theme_texts.dart';

TextTheme withingTextTheme(
  WithingDefaultColors withingColors,
  WithingDefaultTexts withingTexts,
) {
  return TextTheme(
    /// Headline
    headlineLarge: TextStyle(
      color: withingColors.headlineTextColor,
      fontSize: withingTexts.headlineLargeSize,
      fontWeight: withingTexts.fontWeightBold,
      height: withingTexts.lineHeightOnePointThree,
    ),
    headlineMedium: TextStyle(
      color: withingColors.headlineTextColor,
      fontSize: withingTexts.headlineMediumSize,
      fontWeight: withingTexts.fontWeightSemiBold,
      height: withingTexts.lineHeightOnePointFour,
    ),

    /// Title
    titleLarge: TextStyle(
      color: withingColors.titleTextColor,
      fontSize: withingTexts.titleLargeSize,
      fontWeight: withingTexts.fontWeightSemiBold,
      height: withingTexts.lineHeightOnePointFour,
    ),
    titleMedium: TextStyle(
      color: withingColors.titleTextColor,
      fontSize: withingTexts.titleMediumSize,
      fontWeight: withingTexts.fontWeightSemiBold,
      height: withingTexts.lineHeightOnePointFour,
    ),
    titleSmall: TextStyle(
      color: withingColors.titleTextColor,
      fontSize: withingTexts.titleSmallSize,
      fontWeight: withingTexts.fontWeightMedium,
      height: withingTexts.lineHeightOnePointFour,
    ),

    /// Body
    bodyLarge: TextStyle(
      color: withingColors.bodyTextColor,
      fontSize: withingTexts.bodyLargeSize,
      fontWeight: withingTexts.fontWeightBold,
      height: withingTexts.lineHeightOnePointFour,
    ),
    bodyMedium: TextStyle(
      color: withingColors.bodyTextColor,
      fontSize: withingTexts.bodyMediumSize,
      fontWeight: withingTexts.fontWeightSemiBold,
      height: withingTexts.lineHeightOnePointFour,
    ),
    bodySmall: TextStyle(
      color: withingColors.bodyTextColor,
      fontSize: withingTexts.bodySmallSize,
      fontWeight: withingTexts.fontWeightMedium,
      height: withingTexts.lineHeightOnePointFour,
    ),

    /// Label
    labelLarge: TextStyle(
      color: withingColors.captionTextColor,
      fontSize: withingTexts.captionLargeSize,
      fontWeight: withingTexts.fontWeightSemiBold,
      height: withingTexts.lineHeightOnePointFour,
    ),
    labelMedium: TextStyle(
      color: withingColors.captionTextColor,
      fontSize: withingTexts.captionMediumSize,
      fontWeight: withingTexts.fontWeightMedium,
      height: withingTexts.lineHeightOnePointFour,
    ),
    labelSmall: TextStyle(
      color: withingColors.captionTextColor,
      fontSize: withingTexts.captionSmallSize,
      fontWeight: withingTexts.fontWeightSemiBold,
      height: withingTexts.lineHeightOnePointFour,
    ),
  );
}
