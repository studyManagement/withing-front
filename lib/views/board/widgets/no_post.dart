import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';

class NoPost extends StatelessWidget{
  const NoPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Image.asset(
            'asset/exclamation.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 12.0),
          Text(
            "아직 등록된 글이 없어요.",
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.gray400),
          ),
        ]),
    );
  }


}