import 'package:flutter/material.dart';

import '../theme/app/app_colors.dart';

class StudyBottomButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color? color;

  const StudyBottomButton({super.key, required this.onTap, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 343,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color:(color==null) ? AppColors.blue600 : color),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
