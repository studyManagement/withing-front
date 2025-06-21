import 'package:flutter/material.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:modi/views/schedule/study/components/study_schedule_list.dart';
import 'package:modi/views/schedule/study/components/study_schedule_vote_list.dart';
import 'package:modi/common/components/tab/common_tab_view.dart';
import 'package:provider/provider.dart';

class StudyScheduleScreenTab extends StatelessWidget {
  final int studyId;

  const StudyScheduleScreenTab({super.key, required this.studyId});

  @override
  Widget build(BuildContext context) {
    final scheduleViewModel = context.read<ScheduleViewModel>();
    final voteViewModel = context.read<ScheduleVoteViewModel>();

    scheduleViewModel.fetchSchedules(studyId);
    voteViewModel.fetchScheduleVotes(studyId);

    return CommonTabView(
      tabTitles: const ["일정", "투표"],
      tabViews: [
        StudyScheduleList(studyId: studyId),
        const StudyScheduleVoteList(),
      ],
    );
  }
}