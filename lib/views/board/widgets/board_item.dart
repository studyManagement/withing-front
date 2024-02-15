import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/model/board/board_model.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/views/board/screen/board_info_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/utils/get_created_string.dart';

class BoardItem extends StatelessWidget {
  final int studyId;
  final bool isOnlyNotice;
  final BoardModel boardItem;

  const BoardItem({
    super.key,
    required this.studyId,
    required this.isOnlyNotice,
    required this.boardItem,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BoardViewModel>();
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            BoardInfoScreen(boardId: boardItem.id,
                viewModel: viewModel)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (isOnlyNotice)
                  ? Offstage(
                offstage: (isNew(boardItem.createdAt.toString()))
                    ? false
                    : true,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                      color: AppColors.red100,
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '신규',
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: AppColors.red400),
                  ),
                ),
              )
                  : Offstage(
                offstage: (boardItem.notice) ? false : true,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Image.asset('asset/notice_pin.png',
                      width: 16, height: 16),
                ),
              ),
              Text(
                boardItem.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Offstage(
            offstage: (isOnlyNotice == true) ? true : false,
            child: Text(
              boardItem.content,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.gray800, fontSize: 13.0),
            ),
          ),
          Row(
            children: [
              Text(
                getCreatedAt(boardItem.createdAt.toString()),
                style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              const Spacer(),
              if(isOnlyNotice == false) Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image.asset('asset/comment.png', width: 16, height: 16),
              ),
              if(isOnlyNotice == false) Text(boardItem.numOfComments.toString(),
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.gray400, fontSize: 13.0))
            ],
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
