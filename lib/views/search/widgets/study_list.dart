import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/common/theme/app/app_fonts.dart';
import 'package:withing/views/search/widgets/gray100_divider.dart';
import '../../../common/components/study_categories_widget.dart';

class StudyList extends StatelessWidget {
  const StudyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const StudyCard();
        },
        separatorBuilder: (context, index) {
          return const Gray100Divider();
        },
        itemCount: 10,
      ),
    );
  }
}

class StudyCard extends StatelessWidget {
  const StudyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/studies/1');
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            StudyHeader(),
            SizedBox(height: 10),
            StudyDetails(),
            SizedBox(height: 12),
            StudyCategoriesWidget(
              categories: [
                "카테고리1",
                "카테고리2",
                "카테고리3",
                "카테고리4",
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StudyHeader extends StatelessWidget {
  const StudyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const title = '네이버 면접 스터디 같이 준비해봐요!';

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 38,
              height: 38,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }
}

class StudyDetails extends StatelessWidget {
  static const details = [
    ("참여 인원", "15/15"),
    ("정기 모임", "매주 목요일 21:00"),
    // ("다음 만남", "2023. 08. 03 (목) 21:00"),
  ];

  const StudyDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var (title, content) in details) {
      widgets.add(
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: AppFonts.fontSize13,
                    color: AppColors.gray400,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: AppFonts.fontSize13,
                    color: AppColors.gray800,
                  ),
            )
          ],
        ),
      );
    }

    return Column(children: widgets);
  }
}
