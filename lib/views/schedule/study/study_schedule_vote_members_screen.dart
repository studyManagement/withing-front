import 'package:flutter/material.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/components/gray_container.dart';

class StudyScheduleVoteMembersScreen extends StatelessWidget {
  final int studyId;
  final int voteId;

  const StudyScheduleVoteMembersScreen(this.studyId, this.voteId, {super.key});

  @override
  Widget build(BuildContext context) {
    ScheduleVoteViewModel voteViewModel = context.read<ScheduleVoteViewModel>();
    ScheduleVote? vote = context.select<ScheduleVoteViewModel, ScheduleVote?>(
        (provider) => provider.vote);

    List<UserModel> users = vote?.votedMembers ?? [];
    bool isLoading = vote == null;

    if (isLoading) {
      voteViewModel.fetchScheduleVote(studyId, voteId);
    }

    return DefaultLayout(
      title: '참여자 정보',
      child: (isLoading)
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            )
          : (users.isEmpty)
              ? ModiException(const ['투표에 참여한 참여자가 없어요.'])
              : ListView.builder(
                  itemExtent: 60,
                  itemBuilder: (context, index) {
                    UserModel user = users[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          CircleImage(
                            size: 38,
                            image: Image.network(user.profileImage!, errorBuilder: (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
                              return const GrayContainer(size: 38);
                            },),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user.nickname,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: AppFonts.fontWeight600,
                              color: AppColors.gray800,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: users.length,
                ),
    );
  }
}
