import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

enum TagColorSet {
  BLUE(AppColors.blue500, AppColors.blue100),
  RED(AppColors.red500, AppColors.red100),
  GRAY(AppColors.gray500, AppColors.gray100);

  final Color textColor;
  final Color backgroundColor;
  const TagColorSet(this.textColor, this.backgroundColor);
}

class Tag extends StatelessWidget {
  TagColorSet colorSet;
  String content;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: colorSet.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          child: Text(
            content,
            style: TextStyle(
              color: colorSet.textColor,
              fontSize: 12,
              fontWeight: AppFonts.fontWeight600,
            ),
          ),
        ));
  }

  Tag(this.content, this.colorSet, {super.key});
}
