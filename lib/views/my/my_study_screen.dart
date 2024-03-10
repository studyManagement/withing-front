import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/study/study_list.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:modi/view_models/study/model/study_list_view.dart';
import 'package:modi/view_models/study/model/study_meeting_schedule.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:provider/provider.dart';

class MyStudyScreen extends StatelessWidget {
  String studyType;

  MyStudyScreen(this.studyType, {super.key});

  @override
  Widget build(BuildContext context) {
    StudyListViewModel vm = context.read<StudyListViewModel>();
    vm.fetchStudies(StudyType.from(studyType));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          (StudyType.from(studyType) == StudyType.LIKE) ? '찜한 스터디' : '종료된 스터디',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: MyStudyListView(StudyType.from(studyType)),
        ),
      ),
    );
  }
}

class MyStudyListView extends StatelessWidget {
  const MyStudyListView(this.studyType, {super.key});

  final StudyType studyType;

  String getNextScheduleDate(DateTime selectedDate,
      StudyMeetingSchedule currentSchedule, StudyMeetingSchedule nextSchedule) {
    DateFormat dateFormat = DateFormat('yyyy.MM.dd');

    if (currentSchedule.id == nextSchedule.id) {
      return dateFormat.format(selectedDate.add(const Duration(days: 7)));
    }

    if (currentSchedule.day == nextSchedule.day) {
      return dateFormat.format(selectedDate);
    }

    int nextDay = 0;

    if (nextSchedule.day > currentSchedule.day) {
      nextDay = nextSchedule.day - currentSchedule.day;
    } else {
      nextDay = (7 - currentSchedule.day) + nextSchedule.day;
    }

    return dateFormat.format(selectedDate.add(Duration(days: nextDay)));
  }

  @override
  Widget build(BuildContext context) {
    final StudyListViewModel vm = context.read<StudyListViewModel>();
    List<StudyListView> studies =
        context.select<StudyListViewModel, List<StudyListView>>(
            (provider) => provider.studyList);

    List<StudyListViewParam> params = [];

    for (var element in studies) {
      Map<String, String> extra = {};

      String regularMeeting;
      String extraElement;

      if (element.meetingSchedules.isNotEmpty) {
        final StudyMeetingSchedule nextMeetingSchedule =
            vm.getNextPromise(element);
        final String nextScheduleDate = getNextScheduleDate(vm.selectedDate,
            element.meetingSchedules.first, nextMeetingSchedule);

        regularMeeting =
            "매주 (${element.getAllWeekdays()}) ${element.getPromiseByDefault().startTime}";

        if (studyType == StudyType.LIKE) {
          extraElement = '${nextScheduleDate}';
        } else {
          extraElement = '';
        }
      } else {
        regularMeeting = "비정기 모임";
        extraElement = "비정기 모임";
      }

      extra['참여 인원'] = "${element.headcount}/${element.max}";
      extra['정기 모임'] = regularMeeting;

      if (studyType == StudyType.LIKE) {
        extra['다음 만남'] = '';
      } else {
        extra['종료일'] = '더미 데이터';
      }

      StudyListViewParam param = StudyListViewParam(
        element.studyName,
        '/studies/${element.id}',
        extra: extra,
        tag: element.categories,
      );

      params.add(param);
    }

    return StudyList(params);
  }
}
