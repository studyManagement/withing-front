import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/utils/get_created_string.dart';

class BoardItem extends StatelessWidget {
  final int studyId;
  final bool isOnlyNotice;
  final int boardId;
  final bool notice;
  final String title;
  final String content;
  final String? nickname;
  final String createdAt;

  const BoardItem(
      {super.key,
      required this.studyId,
      required this.isOnlyNotice,
      required this.boardId,
      required this.notice,
      required this.title,
      required this.content,
      this.nickname,
      required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.push('/studies/$studyId/boards/$boardId').then((value) => print('a'));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (isOnlyNotice) ?
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
              ) :   Offstage(
                offstage: (notice) ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(right:4.0),
                  child: Image.asset('asset/notice_pin.png', width: 16, height: 16),
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
            offstage: (isOnlyNotice == true) ? true:false,
            child: Text(
              content,
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



bool isNew(String createdAt) {
  // true: 신규 태그
  DateTime time = DateTime.parse(createdAt);
  DateTime now = DateTime.now();
  DateTime twentyFourHoursAgo = now.subtract(const Duration(hours: 24));
  return !time.isBefore(twentyFourHoursAgo);
}
