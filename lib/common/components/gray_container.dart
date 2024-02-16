import 'package:flutter/material.dart';

import '../theme/app/app_colors.dart';

class GrayContainer extends StatelessWidget {
  final double size;

  const GrayContainer({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Container(width: size, height: size, color: AppColors.gray150));
  }
}
