import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class ConfirmButton extends StatelessWidget {
  final Function()? onTap;
  final double? width;
  final double? height;
  final String text;
  final Color backgroundColor;

  const ConfirmButton({
    Key? key,
    this.width,
    this.height = 42,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget button = InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: backgroundColor),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white, fontWeight: AppFonts.fontWeight600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    if (width == null) {
      return Expanded(child: button);
    }

    return button;
  }
}
