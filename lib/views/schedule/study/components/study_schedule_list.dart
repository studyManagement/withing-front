import 'package:flutter/material.dart';
import 'package:modi/common/components/tag/tag.dart';
import 'package:modi/common/theme/theme_resources.dart';

class StudyScheduleList extends StatelessWidget {
  const StudyScheduleList({
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
              return _StudyScheduleItem(
                  '실무 면접 및 대면 피드백', '08. 03 (목) 오전 9:00 - 오후 1:00',
                  tag: '오늘');
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

class _StudyScheduleItem extends StatelessWidget {
  _StudyScheduleItem(
    this.title,
    this.content, {
    this.tag,
    super.key,
  });

  String? tag;
  String title;
  String content;

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
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            color: AppColors.gray400,
            fontSize: 13,
            fontWeight: AppFonts.fontWeight500,
          ),
        ),
      ],
    );
  }
}
