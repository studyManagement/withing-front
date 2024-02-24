import 'package:flutter/material.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/theme/theme_resources.dart';

class StudyScheduleVoteList extends StatelessWidget {
  const StudyScheduleVoteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                '전체',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.gray400,
                  fontWeight: AppFonts.fontWeight600,
                ),
              ),
              SizedBox(width: 6),
              Text(
                '9,999',
                style: TextStyle(
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
              return _StudyScheduleVoteItem(
                  '실무 면접 및 대면 피드백', 20, 12, DateTime.now(),
                  tag: '미참여');
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
            itemCount: 10,
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
