import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

import '../../theme/app/app_colors.dart';

class ValueButton extends StatelessWidget {
  final Function()? onTap;
  final Color? borderColor;

  const ValueButton(this.value, {super.key, this.onTap, this.borderColor});

  final String value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: borderColor ?? AppColors.gray150),
          color: AppColors.white,
        ),
        child: Text(
          value,
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
