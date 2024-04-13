import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

import '../../theme/app/app_colors.dart';

class ValueButton extends StatelessWidget {
  final Function()? onTap;
  final Color? borderColor;
  final Widget? rightWidget;
  final TextAlign? textAlign;

  const ValueButton(
    this.value, {
    super.key,
    this.onTap,
    this.borderColor,
    this.rightWidget,
    this.textAlign,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderColor ?? AppColors.gray150),
          color: AppColors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  value,
                  textAlign: textAlign,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            if (rightWidget != null) rightWidget!,
          ],
        ),
      ),
    );
  }
}
