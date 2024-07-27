import 'package:flutter/material.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.blue400),
    );
  }
}
