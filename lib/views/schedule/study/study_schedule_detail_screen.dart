import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/share/share.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/action_sheet_params.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/schedule/model/schedule_detail.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/authenticator/authentication.dart';
import '../../common/share/share_button.dart';

class StudyScheduleDetailScreen extends StatelessWidget {
  const StudyScheduleDetailScreen(
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

  String _getDateString(DateTime dateTime) {
    String timeDifference = (dateTime.hour >= 12) ? '오후' : '오전';
    String hour = (dateTime.hour > 12) ? (dateTime.hour - 12)
        .toString()
        .padLeft(2, '0') : dateTime.hour.toString().padLeft(2, '0');
    return "${dateTime.year}. ${dateTime.month.toString().padLeft(
        2, '0')}. ${dateTime.day.toString().padLeft(2, '0')} $timeDifference $hour:${dateTime
        .minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel scheduleViewModel = context.read<ScheduleViewModel>();
    StudyViewModel studyViewModel = context.read<StudyViewModel>();

    ScheduleDetail scheduleDetail =
    context.select<ScheduleViewModel, ScheduleDetail>(
            (provider) => provider.schedule);

    String studyName = context.select<StudyViewModel, String>(
            (provider) => provider.study?.studyName ?? '');

    DateFormat dateFormatter = DateFormat('yyyy. MM. dd. HH:mm');

    if (scheduleDetail.id == -1) {
      studyViewModel.fetchStudyInfo(context, studyId);
      scheduleViewModel.fetchSchedule(studyId, studyScheduleId);
    }

    List<Widget> headerWidget = [];

    if (scheduleDetail.id != -1 && _isToday(scheduleDetail.startAt)) {
      headerWidget.add(Tag('오늘', TagColorSet.RED));
      headerWidget.add(const SizedBox(width: 6));
    }
    else if(DateTime.now().isAfter(scheduleDetail.endAt)){
      headerWidget.add(Tag('마감', TagColorSet.GRAY));
      headerWidget.add(const SizedBox(width: 6));
    }

    return DefaultLayout(
      title: '',
      actions: [
        makeShareButton(
          context,
          title: '[$studyName] ${scheduleDetail.title}',
          message: '스터디 일정을 확인해 주세요.',
          path: '/studies/$studyId/schedules/$studyScheduleId',
          contentType: 'study_schedule',
          itemId: '$studyScheduleId'
        ),
        const SizedBox(width: 12),
        if(StudyViewModel.leaderId == Authentication.instance.userId)
          CircleButton(
              onTap: () {
                ModiModal.openActionSheet(
                  context,
                  [
                    ActionSheetParams(
                        title: '수정하기',
                        onTap: () =>
                            context.push(
                                '/studies/$studyId/schedules/register?scheduleId=$studyScheduleId')),
                    ActionSheetParams(
                      title: '삭제하기',
                      titleColor: AppColors.red400,
                      onTap: () =>
                          scheduleViewModel.deleteSchedule(context, studyId),
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.more_horiz)),
      ],
      child: (scheduleDetail.id == -1)
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator(color: AppColors.blue400,)],
        ),
      )
          : Padding(
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
              _getDateString(scheduleDetail.startAt),
            ),
            const SizedBox(height: 8),
            _makeScheduleDescription(
              '종료',
              _getDateString(scheduleDetail.endAt),
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
      ),
    );
  }
}
