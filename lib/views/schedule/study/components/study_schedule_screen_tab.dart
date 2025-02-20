import 'package:flutter/material.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:modi/views/schedule/study/components/study_schedule_list.dart';
import 'package:modi/views/schedule/study/components/study_schedule_vote_list.dart';
import 'package:provider/provider.dart';

import '../../../../common/theme/app/app_colors.dart';
import '../../../../common/theme/app/app_fonts.dart';

class StudyScheduleScreenTab extends StatefulWidget {
  const StudyScheduleScreenTab({super.key, required this.studyId});

  final int studyId;

  @override
  State<StatefulWidget> createState() => _StudyScheduleScreenTabState();
}

class _StudyScheduleScreenTabState extends State<StudyScheduleScreenTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScheduleViewModel scheduleViewModel = context.read<ScheduleViewModel>();
    ScheduleVoteViewModel voteViewModel = context.read<ScheduleVoteViewModel>();
    scheduleViewModel.fetchSchedules(widget.studyId);
    voteViewModel.fetchScheduleVotes(widget.studyId);

    return Column(
      children: [
        TabBar(
          controller: tabController,
          dividerColor: AppColors.gray150,
          indicatorColor: AppColors.blue600,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0),
          ),
          labelStyle: const TextStyle(
            color: AppColors.gray800,
            fontWeight: AppFonts.fontWeight600,
            fontSize: 16,
          ),
          unselectedLabelStyle: const TextStyle(
            color: AppColors.gray300,
            fontWeight: AppFonts.fontWeight600,
            fontSize: 16,
          ),
          indicatorWeight: 2,
          tabs: const [
            Tab(text: "일정"),
            Tab(text: "투표"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              StudyScheduleList(studyId: widget.studyId),
              const StudyScheduleVoteList(),
            ],
          ),
        ),
      ],
    );
  }
}
