import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class ScheduleListItem extends StatefulWidget {
  final Color? barColor;
  final DateTime startAt;
  final DateTime endAt;
  final String title;
  final String description;
  const ScheduleListItem({
    super.key,
    required this.barColor,
    required this.startAt,
    required this.endAt,
    required this.title,
    required this.description,
  });

  @override
  State<ScheduleListItem> createState() => _ScheduleListItemState();
}

class _ScheduleListItemState extends State<ScheduleListItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 70,
          decoration: BoxDecoration(color: widget.barColor),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${DateFormat.jm('ko').format(widget.startAt)} - ${DateFormat.jm('ko').format(widget.endAt)}',
                  style: const TextStyle(
                    fontWeight: AppFonts.fontWeight500,
                    fontSize: AppFonts.fontSize13,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: AppColors.gray800,
                    fontWeight: AppFonts.fontWeight600,
                    fontSize: AppFonts.fontSize16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Row(
              children: [
                Text(
                  widget.description,
                  style: const TextStyle(
                    color: AppColors.gray400,
                    fontWeight: AppFonts.fontWeight600,
                    fontSize: AppFonts.fontSize14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
