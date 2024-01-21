import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';

class StudyMainButtons extends StatelessWidget {
  final Function()? onTap;
  final Widget? image;
  final String title;
  final String subtitle;

  const StudyMainButtons({
    super.key,
    required this.onTap,
    this.image,
    required this.title,
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: image),
            Positioned(
                left: 14,
                top: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,),
                    Text(
                      subtitle,
                      style: Theme
                          .of(context)
                          .textTheme
                          .labelMedium?.copyWith(color:AppColors.gray400)),

                  ],
                ))
          ],
        ),
      ),
    );
  }
}
