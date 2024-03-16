import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/schedule/model/schedule_detail.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:provider/provider.dart';

class StudyScheduleDetail extends StatelessWidget {
  const StudyScheduleDetail(
      {required this.studyId, required this.studyScheduleId, super.key});

  final int studyId;
  final int studyScheduleId;

  Widget _makeScheduleDescription(String title, String content) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.gray400,
            fontWeight: AppFonts.fontWeight500,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          content,
          style: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight500,
            fontSize: 13,
          ),
        )
      ],
    );
  }

  bool _isToday(DateTime startAt) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime _startAt = DateTime(startAt.year, startAt.month, startAt.day);

    return today == _startAt;
  }

  @override
  Widget build(BuildContext context) {
    ScheduleDetail scheduleDetail =
        context.select<ScheduleViewModel, ScheduleDetail>(
            (provider) => provider.schedule);

    DateFormat dateFormatter = DateFormat('yyyy. MM. dd. HH:mm');

    if (scheduleDetail.id == -1) {
      ScheduleViewModel vm = context.read<ScheduleViewModel>();
      vm.fetchSchedule(studyId, studyScheduleId);
    }

    List<Widget> headerWidget = [];

    if (scheduleDetail.id != -1 && _isToday(scheduleDetail.startAt)) {
      headerWidget.add(Tag('오늘', TagColorSet.RED));
      headerWidget.add(const SizedBox(width: 6));
    }

    return DefaultLayout(
        title: '',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ...headerWidget,
                  Text(
                    scheduleDetail.title,
                    style: const TextStyle(
                      color: AppColors.gray800,
                      fontWeight: AppFonts.fontWeight600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  thickness: 1,
                  color: AppColors.gray50,
                ),
              ),
              _makeScheduleDescription(
                '시작',
                dateFormatter.format(scheduleDetail.startAt),
              ),
              const SizedBox(height: 8),
              _makeScheduleDescription(
                '종료',
                dateFormatter.format(scheduleDetail.endAt),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  thickness: 1,
                  color: AppColors.gray50,
                ),
              ),
              Text(
                scheduleDetail.description,
                style: const TextStyle(
                  color: AppColors.gray600,
                  fontWeight: AppFonts.fontWeight500,
                  fontSize: 14,
                ),
              )
            ],
          ),
        ));
  }
}
