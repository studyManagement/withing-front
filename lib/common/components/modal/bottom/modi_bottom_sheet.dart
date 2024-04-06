import 'package:flutter/cupertino.dart';

import '../../../theme/app/app_colors.dart';

class ModiBottomSheet extends StatelessWidget {
  const ModiBottomSheet(
    this._widget,
    this._height, {
    super.key,
  });

  final Widget _widget;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.zero,
            bottomRight: Radius.zero),
      ),
      width: MediaQuery.of(context).size.width,
      child: _widget,
    );
  }
}
