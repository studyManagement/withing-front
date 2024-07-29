import 'package:flutter/material.dart';
import 'package:modi/common/components/button/confirm_button.dart';
import 'package:modi/common/components/table/schedule/schedule_table.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/theme_resources.dart';
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
    if(isLoading){
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
        title: '일정 투표',
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: isLoading
            ? null
            : Container(
                color: AppColors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ConfirmButton(
                  width: MediaQuery.of(context).size.width,
                  onTap: () {
                    voteViewModel.castVote(context, studyId, voteId);
                  }, // 투표 하기
                  text: '투표 완료',
                  backgroundColor: AppColors.blue600,
                ),
              ),
        child: (isLoading)
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: AppColors.blue400),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      ScheduleTable(
                        dateTimes: vote.votes.map((e) => e.voteDay).toList(),
                        startAt: vote.votes.first.startAt,
                        endAt: vote.votes.first.endAt,
                        voteStatus: const {},
                        maxVoteCount: 1,
                        readOnly: false,
                        onClick: (value) {
                          voteViewModel.selectVoteDateAndTimes(value.value);
                        },
                      ),
                    ],
                  ),
                ),
              ));
  }

  const StudyScheduleVoteChoiceScreen(this.studyId, this.voteId, {super.key});
}
