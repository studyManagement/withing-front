import 'dart:ui';
import '../app/app_fonts.dart';

class WithingDefaultTexts extends AbstractThemeTexts {
  const WithingDefaultTexts();
}

abstract class AbstractThemeTexts {
  const AbstractThemeTexts();

  /// Font Size
  double get headlineLargeSize => AppFonts.fontSize24;
  double get headlineMediumSize => AppFonts.fontSize20;
  double get titleLargeSize => AppFonts.fontSize18;
  double get titleMediumSize => AppFonts.fontSize16;
  double get titleSmallSize => AppFonts.fontSize16;
  double get bodyLargeSize => AppFonts.fontSize14;
  double get bodyMediumSize => AppFonts.fontSize14;
  double get bodySmallSize => AppFonts.fontSize14;
  double get captionLargeSize => AppFonts.fontSize12;
  double get captionMediumSize => AppFonts.fontSize12;
  double get captionSmallSize => AppFonts.fontSize10;

  /// Font Weight
  FontWeight get fontWeightBold => AppFonts.fontWeight700;
  FontWeight get fontWeightSemiBold => AppFonts.fontWeight600;
  FontWeight get fontWeightMedium => AppFonts.fontWeight500;

  /// Line Height
  double get lineHeightOnePointFour => AppFonts.lineHeight140;
  double get lineHeightOnePointThree => AppFonts.lineHeight130;
}
