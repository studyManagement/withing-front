import 'dart:ui';

class ActionSheetParams {
  final String title;
  final Color? titleColor;
  final Function() onTap;

  const ActionSheetParams({
    required this.title,
    required this.onTap,
    this.titleColor,
  });
}
