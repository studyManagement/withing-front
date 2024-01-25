import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/theme/app/app_colors.dart';

AppBar boardAppBar(
    BuildContext context, String title,Function()? onBack, Widget action) {
  List<Widget> actions = [action];
  return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      backgroundColor: AppColors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: (onBack != null) ? onBack : (){context.pop();}

      ),
      centerTitle: true,
      foregroundColor: AppColors.black,
      elevation: 0,
      actions: actions,

  );
}
