import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class ScheduleListItem extends StatelessWidget {
  final String studyName;
  final String scheduleName;
  final bool isLast;
  final String startTime;
  final String endTime;

  const ScheduleListItem({
    super.key,
    required this.studyName,
    required this.scheduleName,
    required this.isLast,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$startTime - $endTime',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.fontSize13,
                      color: AppColors.gray600,
                    ),
                  ),
                  Text(
                    scheduleName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.gray800,
                    ),
                  ),
                  Text(
                    studyName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize14,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast)
          const Divider(
            height: 1.0,
            thickness: 1.0,
            indent: 16.0,
            endIndent: 16.0,
            color: AppColors.gray100,
          ),
      ],
    );
  }
}
