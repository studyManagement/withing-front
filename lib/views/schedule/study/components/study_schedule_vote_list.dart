import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/exception/modi_exception.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/theme/theme_resources.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:provider/provider.dart';

class StudyScheduleVoteList extends StatelessWidget {
  const StudyScheduleVoteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<ScheduleVote> votes =
        context.select<ScheduleVoteViewModel, List<ScheduleVote>>(
            (provider) => provider.votes);

    return votes.isEmpty
        ? ModiException(const ['생성된 투표가 없어요.'])
        : Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const Text(
                      '전체',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.gray400,
                        fontWeight: AppFonts.fontWeight600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${votes.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.gray600,
                        fontWeight: AppFonts.fontWeight600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    ScheduleVote vote = votes[index];

                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        context.push(
                            '/studies/${vote.studyId}/schedules/vote/${vote.id}');
                      },
                      child: _StudyScheduleVoteItem(
                        vote.title,
                        20,
                        12,
                        vote.createdAt,
                        tag: '미참여',
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        thickness: 1,
                        color: AppColors.gray50,
                      ),
                    );
                  },
                  itemCount: votes.length,
                ),
              ),
            ],
          );
  }
}

class _StudyScheduleVoteItem extends StatelessWidget {
  String? tag;
  String title;
  int numberOfPeople;
  int currentPeople;
  DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (tag != null) {
      widgets.add(Tag(tag!, TagColorSet.RED));
      widgets.add(const SizedBox(width: 6));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...widgets,
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray800,
                fontWeight: AppFonts.fontWeight600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              '투표 인원',
              style: TextStyle(
                color: AppColors.gray400,
                fontSize: 13,
                fontWeight: AppFonts.fontWeight500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$currentPeople/$numberOfPeople',
              style: const TextStyle(
                color: AppColors.gray800,
                fontSize: 13,
                fontWeight: AppFonts.fontWeight500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Text(
              '투표 생성',
              style: TextStyle(
                color: AppColors.gray400,
                fontSize: 13,
                fontWeight: AppFonts.fontWeight500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              createdAt.toString(),
              style: const TextStyle(
                color: AppColors.gray800,
                fontSize: 13,
                fontWeight: AppFonts.fontWeight500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _StudyScheduleVoteItem(
      this.title, this.numberOfPeople, this.currentPeople, this.createdAt,
      {super.key, this.tag});
}
