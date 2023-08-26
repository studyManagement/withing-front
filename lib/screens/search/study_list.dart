import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          return const Divider(
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFEBF1F5),
          );
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
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          StudyHeader(),
          SizedBox(height: 10),
          StudyDetails(),
          SizedBox(height: 12),
          StudyCategories()
        ],
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE0E8F0),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              title,
              style: TextStyle(
                color: Color(0xFF22262B),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
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
    ("다음 만남", "2023. 08. 03 (목) 21:00"),
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
              style: const TextStyle(
                color: Color(0xFF8B97A4),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              content,
              style: const TextStyle(
                color: Color(0xFF22262B),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      );
    }

    return Column(children: widgets);
  }
}

class StudyCategories extends StatelessWidget {
  static const categories = [
    "카테고리1",
    "카테고리2",
    "카테고리3",
    "카테고리4",
  ];

  const StudyCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var category in categories) {
      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: ShapeDecoration(
            color: const Color(0xFFE3F1FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Text(
            category,
            style: const TextStyle(
              color: Color(0xFF3771E0),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

      if (category != categories.last) {
        widgets.add(const SizedBox(width: 6));
      }
    }

    return Row(children: widgets);
  }
}
