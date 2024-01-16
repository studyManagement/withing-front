import 'package:flutter/material.dart';

import '../../../common/theme/app/app_colors.dart';

class StudyMainButtons extends StatelessWidget {
  final String Path;
  final String title;

  const StudyMainButtons({
    super.key,
    required this.Path,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: GestureDetector(
        onTap: () {

        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              decoration: ShapeDecoration(
                color: AppColors.gray50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Positioned(
                left: 14,
                top: 14,
                child: Text(
                  title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,))
          ],
        ),
      ),
    );
  }
}
