import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/components/share/share.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/modal/action_sheet_params.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:modi/view_models/study/model/study_view.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/button/circle_button.dart';
import '../../../common/components/button/confirm_button.dart';
import '../../../common/components/table/schedule/schedule_table.dart';

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

    int userId = Authentication.instance.userId;

    List<UserModel> members = context.select<StudyViewModel, List<UserModel>>(
        (provider) => provider.study?.users ?? []);

    String studyName = context.select<StudyViewModel, String>(
        (provider) => provider.study?.studyName ?? '');

    bool isVoted = vote?.isVoted(userId) ?? false;
    bool isLoading = vote == null;

    if (isLoading) {
      studyViewModel.fetchStudyInfo(studyId);
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
      title: '',
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoading
          ? null
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ConfirmButton(
                width: MediaQuery.of(context).size.width,
                onTap: () {},
                text: isVoted ? '다시 투표하기' : '투표하기',
                backgroundColor: AppColors.blue600,
              ),
            ),
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
                ActionSheetParams(
                    title: '마감하기',
                    onTap: () {
                      context.push(
                          '/studies/$studyId/schedules/vote/$voteId/confirm');
                    }),
                ActionSheetParams(
                  title: '삭제하기',
                  onTap: () {},
                  titleColor: AppColors.red400,
                ),
              ],
            );
          },
          icon: const Icon(Icons.more_horiz),
        ),
      ],
      child: (isLoading)
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  StudyScheduleVoteDetailHeader(isVoted: isVoted),
                  const Divider(color: AppColors.gray50, thickness: 6),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ScheduleTable(
                      dateTimes: vote.votes.map((e) => e.voteDay).toList(),
                      startAt: vote.votes.first.startAt,
                      endAt: vote.votes.first.endAt,
                      voteStatus: vote.toTableVoteStatus(),
                      maxVoteCount: members.length,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class StudyScheduleVoteDetailHeader extends StatelessWidget {
  const StudyScheduleVoteDetailHeader({
    super.key,
    required this.isVoted,
  });

  final bool isVoted;

  Row _makeHeader(String title, Widget body) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: AppFonts.fontWeight500,
            color: AppColors.gray400,
          ),
        ),
        const SizedBox(width: 8),
        body,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormatter = DateFormat('yyyy. MM. dd. HH:mm');
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);
    List<UserModel> members = context.select<StudyViewModel, List<UserModel>>(
        (provider) => provider.study?.users ?? []);
    StudyView? studyView = context
        .select<StudyViewModel, StudyView?>((provider) => provider.study);

    bool isLoading = vote == null;

    if (isLoading) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Tag(
                isVoted ? '참여완료' : '미참여',
                isVoted ? TagColorSet.GRAY : TagColorSet.RED,
              ),
              const SizedBox(width: 8),
              Text(
                vote.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: AppFonts.fontWeight600,
                  color: AppColors.gray800,
                ),
              ),
            ],
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
          _makeHeader(
            '확정 일정',
            const Text(
              '-',
              style: TextStyle(
                  color: AppColors.gray800,
                  fontSize: 13,
                  fontWeight: AppFonts.fontWeight500),
            ),
          ),
          const SizedBox(height: 8),
          _makeHeader(
            '투표 인원',
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                context.push(
                    '/studies/${studyView?.id ?? -1}/schedules/vote/${vote.id}/members');
              },
              child: Row(
                children: [
                  Text(
                    '${vote.totalVoteCount}/${members.length}',
                    style: const TextStyle(
                        color: AppColors.gray800,
                        fontSize: 13,
                        fontWeight: AppFonts.fontWeight500),
                  ),
                  Image.asset(
                    'asset/arrowright16.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          _makeHeader(
            '투표 생성',
            Text(
              dateFormatter.format(vote.createdAt),
              style: const TextStyle(
                  color: AppColors.gray800,
                  fontSize: 13,
                  fontWeight: AppFonts.fontWeight500),
            ),
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }
}
