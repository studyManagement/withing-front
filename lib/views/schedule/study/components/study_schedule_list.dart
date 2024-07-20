import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/schedule/model/schedule.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class StudyScheduleList extends StatelessWidget {
  const StudyScheduleList({
    required this.studyId,
    super.key,
  });

  final int studyId;

  bool _isToday(DateTime startAt) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime _startAt = DateTime(startAt.year, startAt.month, startAt.day);

    return today == _startAt;
  }

  String _makeScheduleDescription(DateTime startAt, DateTime endAt) {
    String startTimeDifference = (startAt.hour >= 12) ? '오후' : '오전';
    String startHour = (startAt.hour > 12) ? (startAt.hour-12).toString().padLeft(2,'0') : startAt.hour.toString().padLeft(2,'0');
    String endTimeDifference = (endAt.hour >= 12) ? '오후' : '오전';
    String endHour = (endAt.hour > 12) ? (endAt.hour-12).toString().padLeft(2,'0') : endAt.hour.toString().padLeft(2,'0');
    if (isSameDay(startAt,endAt)) {
      return"${startAt.month}. ${startAt.day} (${WeekString[startAt.weekday -
          1]}) $startTimeDifference $startHour:${startAt
          .minute.toString().padLeft(2,'0')} - $endTimeDifference $endHour:${endAt.minute.toString().padLeft(2,'0')}";
    }
    return "${startAt.month}. ${startAt.day} (${WeekString[startAt.weekday -
        1]}) $startTimeDifference $startHour:${startAt
        .minute.toString().padLeft(2,'0')} - ${endAt.month}. ${endAt.day} (${WeekString[endAt.weekday -
        1]}) $endTimeDifference $endHour:${endAt.minute.toString().padLeft(2,'0')}";
  }

  @override
  Widget build(BuildContext context) {
    final List<Schedule>? schedules =
    context.select<ScheduleViewModel, List<Schedule>?>(
            (provider) => provider.schedules);

    bool isLoading = schedules == null;

    return (isLoading)
        ? const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    )
        : schedules.isEmpty
        ? ModiException(const ['생성된 일정이 없어요.'])
        : Column(
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

              return GestureDetector(
                onTap: () {
                  context.push(
                      '/studies/$studyId/schedules/${schedule.id}');
                },
                behavior: HitTestBehavior.translucent,
                child: _StudyScheduleItem(
                    schedule.title,
                    _makeScheduleDescription(
                        schedule.startAt, schedule.endAt),
                    tag: _isToday(schedule.startAt) ? '오늘' : DateTime.now().isAfter(schedule.endAt) ? '마감' :null),
              );
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
  _StudyScheduleItem(this.title,
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

    if (tag == '오늘') {
      widgets.add(Tag(tag!, TagColorSet.RED));
      widgets.add(const SizedBox(width: 6));
    }
    if (tag == '마감') {
      widgets.add(Tag(tag!, TagColorSet.GRAY));
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
