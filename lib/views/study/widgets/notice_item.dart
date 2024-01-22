import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../common/theme/app/app_colors.dart';

class NoticeItem extends StatelessWidget {
  final int boardId;
  final String title;
  final String? content;
  final String createdAt;

  NoticeItem(
      {super.key,
      required this.boardId,
      required this.title,
      this.content,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 공지 상세 페이지로 이동
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Offstage(
                offstage: (isNew(createdAt)) ? false : true,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppColors.red100,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '신규',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.red400),
                  ),
                ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Offstage(
            offstage: (content == null) ? true : false,
            child: Text(
              content!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.gray800, fontSize: 13.0),
            ),
          ),
          Text(
            getCreatedAt(createdAt),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
          ),
        ]),
      ),
    );
  }
}

String getCreatedAt(String createdAt) {
  createdAt = createdAt.substring(0, 16);
  createdAt = createdAt.replaceAll('-', '. ');
  createdAt = createdAt.replaceAll('T', '. ');
  return createdAt;
}

bool isNew(String createdAt) {
  // true: 신규 태그
  DateTime time = DateTime.parse(createdAt);
  DateTime now = DateTime.now();
  DateTime twentyFourHoursAgo = now.subtract(const Duration(hours: 24));
  return !time.isBefore(twentyFourHoursAgo);
}
