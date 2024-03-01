import 'package:flutter/material.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/theme/theme_resources.dart';

class LabelCircleButton extends StatelessWidget {
  const LabelCircleButton(this.label, this.image, this.onTap, {super.key});

  final String label;
  final Image image;
  final Function() onTap;

  @override
  Widget build(BuildContext) {
    return Column(
      children: [
        CircleButton(
          onTap: onTap,
          image: image,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
