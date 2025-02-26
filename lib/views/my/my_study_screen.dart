import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/components/study/study_list.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/utils/get_regular_meeting_string.dart';
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

    return DefaultLayout(
      resizeToAvoidBottomInset: false,
      leader: CircleButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onTap: () => Navigator.of(context).pop(),
      ),
      title:
          (StudyType.from(studyType) == StudyType.LIKE) ? '찜한 스터디' : '종료된 스터디',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: MyStudyListView(StudyType.from(studyType)),
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

        regularMeeting = getRegularMeetingString(element.meetingSchedules);

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

      StudyListViewParam param = StudyListViewParam(
          element.studyName, '/studies/${element.id}',
          extra: extra, tag: element.categories, imagePath: element.studyImage);

      params.add(param);
    }

    return (studies.isEmpty)
        ? ModiException(
            ["${studyType == StudyType.LIKE ? "찜한" : "종료된"} 스터디가 없어요."])
        : StudyList(params);
  }
}
