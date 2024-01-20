import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class NoticeItem extends StatelessWidget {
  final int boardId;
  final String title;
  final String? content;
  final String date;

  NoticeItem(
      {super.key, required this.boardId, required this.title, this.content, required this.date});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 공지 상세 페이지로 이동
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
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
            date,
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


