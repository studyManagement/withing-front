import 'package:flutter/material.dart';
import 'package:modi/common/components/table/schedule/schedule_table.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:provider/provider.dart';

class StudyScheduleVoteChoiceScreen extends StatelessWidget {
  final int studyId;
  final int voteId;

  @override
  Widget build(BuildContext context) {
    ScheduleVoteViewModel voteViewModel = context.read<ScheduleVoteViewModel>();
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);

    bool isLoading = vote == null;

    if (isLoading) {
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
        title: '일정 투표',
        child: (isLoading)
            ? const Column(
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ScheduleTable(
                      dateTimes: vote.votes.map((e) => e.voteDay).toList(),
                      startAt: vote.votes.first.startAt,
                      endAt: vote.votes.first.endAt,
                      voteStatus: const {},
                      maxVoteCount: 1,
                      readOnly: true,
                    ),
                  ],
                ),
              ));
  }

  const StudyScheduleVoteChoiceScreen(this.studyId, this.voteId, {super.key});
}
