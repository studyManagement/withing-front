import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class ScheduleListItem extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final bool isLast;
  final DateTime startAt;
  final DateTime endAt;

  const ScheduleListItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.isLast,
    required this.startAt,
    required this.endAt,
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
                    '${DateFormat.jm('ko').format(startAt).toString()} - ${DateFormat.jm('ko').format(endAt).toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: AppFonts.fontSize13,
                      color: AppColors.gray600,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.gray800,
                    ),
                  ),
                  Text(
                    description,
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
