import 'package:flutter/material.dart';
import 'package:modi/common/components/share/share.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/action_sheet_params.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/circle_button.dart';

class StudyScheduleVoteDetailScreen extends StatelessWidget {
  const StudyScheduleVoteDetailScreen(this.studyId, this.voteId, {super.key});

  final int studyId;
  final int voteId;

  Widget _makeShareButton(
      BuildContext context, String title, String message, String path) {
    return CircleButton(
      onTap: () {
        ModiModal.openBottomSheet(
          context,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
            child: Share(
              title: title,
              message: message,
              path: path,
              contentType: 'study_schedule_vote',
              itemId: '$voteId',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          height: 221,
        );
      },
      image: Image.asset('asset/share.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScheduleVoteViewModel voteViewModel = context.read<ScheduleVoteViewModel>();
    StudyViewModel studyViewModel = context.read<StudyViewModel>();
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);

    String studyName = context.select<StudyViewModel, String>(
        (provider) => provider.study?.studyName ?? '');

    if (vote == null) {
      studyViewModel.fetchStudyInfo(studyId);
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
      title: '',
      actions: [
        _makeShareButton(
          context,
          '[$studyName] ${vote?.title}',
          '스터디 일정을 투표해 주세요',
          '/studies/$studyId/schedules/vote/$voteId',
        ),
        const SizedBox(width: 12),
        CircleButton(
          onTap: () {
            ModiModal.openActionSheet(
              context,
              [
                ActionSheetParams(title: '수정하기', onTap: () {}),
                ActionSheetParams(title: '삭제하기', onTap: () {}),
              ],
            );
          },
          icon: const Icon(Icons.more_horiz),
        ),
      ],
      child: (vote == null)
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            )
          : const Column(
              children: [
                StudyScheduleVoteDetailHeader(),
                Divider(color: AppColors.gray50, thickness: 6),
              ],
            ),
    );
  }
}

class StudyScheduleVoteDetailHeader extends StatelessWidget {
  const StudyScheduleVoteDetailHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);

    if (vote == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vote.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: AppFonts.fontWeight600,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            vote.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.gray150),
          const SizedBox(height: 16),
          const Text(
            '확정 일정',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray400,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '투표 인원',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray400,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '투표 생성',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.fontWeight500,
              color: AppColors.gray400,
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
