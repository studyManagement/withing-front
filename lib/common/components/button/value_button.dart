import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

import '../../theme/app/app_colors.dart';

class ValueButton extends StatelessWidget {
  const ValueButton(
    this.value, {
    super.key,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: AppColors.gray150),
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
    );
  }
}
