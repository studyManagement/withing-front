import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/components/selector/radio_selector.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/confirm_button.dart';

class StudyScheduleVoteConfirmScreen extends StatelessWidget {
  final int studyId;
  final int voteId;

  const StudyScheduleVoteConfirmScreen(this.studyId, this.voteId, {super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleVoteViewModel voteViewModel = context.read<ScheduleVoteViewModel>();
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);
    bool isLoading = vote == null;

    final dateTimeFormatter = DateFormat('MM. dd (E) a hh:mm', 'ko');

    List<ScheduleVoteItemAggregate> aggregates = vote?.voteAggregates ?? [];
    List<RadioItem> voteItems = aggregates
            .sublist(0, (aggregates.length > 5) ? 5 : aggregates.length)
            .map(
              (e) => RadioItem<DateTime>(
                value: DateTime(
                  e.voteDay.year,
                  e.voteDay.month,
                  e.voteDay.day,
                  e.selectedTime.hour,
                  0,
                ),
                title: '${dateTimeFormatter.format(DateTime(
                  e.voteDay.year,
                  e.voteDay.month,
                  e.voteDay.day,
                  e.selectedTime.hour,
                  0,
                ))} - ${e.selectedTime.hour + 1}:00',
              ),
            )
            .toList() ??
        [];

    log('voteItems: $voteItems');
    log('voteAggregates: ${vote?.voteAggregates}');

    if (isLoading) {
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
      title: '일정 확정',
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: ConfirmButton(
          width: MediaQuery.of(context).size.width,
          onTap: () {},
          text: '확정하기',
          backgroundColor: AppColors.blue600,
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '투표 결과',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.gray500,
                    fontWeight: AppFonts.fontWeight600,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '상위 5개',
                  style: TextStyle(
                    color: AppColors.gray300,
                    fontSize: 13,
                    fontWeight: AppFonts.fontWeight500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RadioSelector(
              onChange: (value) {},
              items: voteItems,
            ),
          ),
        ],
      ),
    );
  }
}
