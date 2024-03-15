import 'package:flutter/material.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/schedule/model/schedule.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:provider/provider.dart';

class StudyScheduleList extends StatelessWidget {
  const StudyScheduleList({
    super.key,
  });

  bool _isToday(DateTime startAt) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime _startAt = DateTime(startAt.year, startAt.month, startAt.day);

    return today == _startAt;
  }

  String _makeScheduleDescription(DateTime startAt, DateTime endAt) {
    String startTimeDifference = (startAt.hour >= 12) ? '오후' : '오전';
    String endTimeDifference = (endAt.hour >= 12) ? '오후' : '오전';

    return "${startAt.month}. ${startAt.day} (${WeekString[startAt.weekday]}) $startTimeDifference ${startAt.hour}:${startAt.minute} - $endTimeDifference ${endAt.hour}:${endAt.minute}";
  }

  @override
  Widget build(BuildContext context) {
    final List<Schedule> schedules =
        context.select<ScheduleViewModel, List<Schedule>>(
            (provider) => provider.schedules);

    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              const Text(
                '전체',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.gray400,
                  fontWeight: AppFonts.fontWeight600,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${schedules.length}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.gray600,
                  fontWeight: AppFonts.fontWeight600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              Schedule schedule = schedules[index];

              return _StudyScheduleItem(schedule.title,
                  _makeScheduleDescription(schedule.startAt, schedule.endAt),
                  tag: _isToday(schedule.startAt) ? '오늘' : null);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 1,
                  color: AppColors.gray50,
                ),
              );
            },
            itemCount: schedules.length,
          ),
        ),
      ],
    );
  }
}

class _StudyScheduleItem extends StatelessWidget {
  _StudyScheduleItem(
    this.title,
    this.content, {
    this.tag,
    super.key,
  });

  String? tag;
  String title;
  String content;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (tag != null) {
      widgets.add(Tag(tag!, TagColorSet.RED));
      widgets.add(const SizedBox(width: 6));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...widgets,
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray800,
                fontWeight: AppFonts.fontWeight600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            color: AppColors.gray400,
            fontSize: 13,
            fontWeight: AppFonts.fontWeight500,
          ),
        ),
      ],
    );
  }
}
