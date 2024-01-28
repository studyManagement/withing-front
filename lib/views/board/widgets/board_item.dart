import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/theme/app/app_colors.dart';

class BoardItem extends StatelessWidget {
  final int boardId; // 해당 게시글 상세 페이지로 이동
  final bool notice; // 공지 여부 (1일시 공지)
  final String title;
  final String? content;
  final String nickname;
  final String createdAt;

  BoardItem(
      {super.key,
      required this.boardId,
      required this.title,
      this.content,
      required this.createdAt,
      required this.notice,
      required this.nickname});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/studies/1/board/1');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Offstage(
                offstage: (notice == 1) ? false : true, // 공지 여부 체크
                child:
                    Padding(
                      padding: const EdgeInsets.only(right:4.0),
                      child: Image.asset('asset/notice_pin.png', width: 32, height: 32),
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.gray800, fontSize: 13.0),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'nickname',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              const SizedBox(width: 8),
              Text(
                '|',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray150, fontSize: 13.0),
              ),
              const SizedBox(width: 8),
              Text(
                getCreatedAt(createdAt),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              const Spacer(),
              Image.asset('asset/comment.png', width: 16, height: 16),
              const SizedBox(width: 4),
              Text(
                '3',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
            ],
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
