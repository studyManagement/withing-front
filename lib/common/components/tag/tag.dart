import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class Tag extends StatelessWidget {
  String content;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.blue100,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          child: Text(
            content,
            style: const TextStyle(
              color: AppColors.blue500,
              fontSize: 12,
              fontWeight: AppFonts.fontWeight600,
            ),
          ),
        ));
  }

  Tag(this.content, {super.key});
}
