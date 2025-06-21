import 'package:flutter/material.dart';

import '../../theme/app/app_colors.dart';
import '../../theme/app/app_fonts.dart';

class IconTextButton extends StatelessWidget {
  final double height;
  final Widget image;
  final String text;
  final Function() onTap;

  const IconTextButton({super.key, required this.height, required this.image, required this.text, required this.onTap});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        height: height,
        decoration: BoxDecoration(
          color: AppColors.gray50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image,
            Text(
              text,
              style: const TextStyle(
                color: AppColors.gray800,
                fontSize: 14,
                fontWeight: AppFonts.fontWeight600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
