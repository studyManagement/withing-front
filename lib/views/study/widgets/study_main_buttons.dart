import 'package:flutter/material.dart';

import '../../../common/layout/responsive_size.dart';
import '../../../common/theme/app/app_colors.dart';

class StudyMainButtons extends StatelessWidget {
  final Function()? onTap;
  final Widget? image;
  final double width;
  final String title;
  final String subtitle;

  const StudyMainButtons(
      {super.key,
      required this.onTap,
      this.image,
      required this.width,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    bool isTabletPrt = MediaQuery.of(context).size.width >= tabletPortrait;
    bool isTabletLsc = MediaQuery.of(context).size.width >= tabletLandscape;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: (isTabletPrt) ? width * 0.5 : width * 0.65,
          decoration: BoxDecoration(
              color: AppColors.gray50, borderRadius: BorderRadius.circular(8.0)),
          child: Stack(
            children: <Widget>[
              Positioned(
                top:  (isTabletPrt) ? width * 0.08 : width * 0.22,
                left:  (isTabletLsc) ? width * 0.5 : (isTabletPrt) ? width * 0.3 : width * 0.45,
                child: Transform.rotate(
                  angle: -11.55 * 3.14 / 180,
                  child: SizedBox(width: width * 0.6, height: width * 0.6, child: image),
                ),
              ),
              Positioned(
                  left: 16,
                  top: 14,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.gray400)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
