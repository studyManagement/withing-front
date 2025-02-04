import 'package:flutter/material.dart';
import '../app/app_colors.dart';

class WithingDefaultColors extends AbstractThemeColors {
  const WithingDefaultColors();
}

abstract class AbstractThemeColors {
  const AbstractThemeColors();

  Color get primaryColor => AppColors.blue600;
  Color get subColor => AppColors.blue200;

  Color get primaryContainerColor => AppColors.gray150;

  Color get backgroundColor => AppColors.white;

  Color get lineColor => AppColors.gray150;

  Color get errorColor => AppColors.red500;

  /// Text Color
  Color get headlineTextColor => AppColors.gray800;
  Color get titleTextColor => AppColors.gray800;
  Color get bodyTextColor => AppColors.gray800;
  Color get captionTextColor => AppColors.gray700;
  Color get defaultTextColor => AppColors.gray500;
  Color get whiteTextColor => AppColors.white;
}
