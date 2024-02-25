import 'package:flutter/material.dart';

import '../../theme/app/app_colors.dart';
import '../../theme/app/app_fonts.dart';

class IconTextButton extends StatelessWidget {
  final double _height;
  final Image _image;
  final String _text;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: _onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        height: _height,
        decoration: BoxDecoration(
          color: AppColors.gray50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _image,
            Text(
              _text,
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

  const IconTextButton(this._height, this._image, this._text, this._onTap,
      {super.key});
}
