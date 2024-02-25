import 'package:flutter/material.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';

class BoardSubmitButton extends StatelessWidget {
  final Function()? onSubmitted;

  const BoardSubmitButton({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final BoardViewModel vm = context.watch<BoardViewModel>();
    return TextButton(
      onPressed: onSubmitted,
      child: Text("등록",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: (vm.isValid) ? AppColors.blue400 : AppColors.gray300,
              fontSize: 16)),
    );
  }
}
