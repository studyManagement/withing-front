import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/model/board/board_model.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/views/board/screen/board_info_screen.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/utils/get_created_string.dart';

class BoardItem extends StatelessWidget {
  final BoardModel boardItem;

  const BoardItem({
    super.key,
    required this.boardItem,
  });

  @override
  Widget build(BuildContext context) {
    bool hasImage = false;
    final viewModel = context.read<BoardViewModel>();
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BoardInfoScreen(
                    boardId: boardItem.id, viewModel: viewModel)));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Offstage(
                        offstage: (boardItem.notice) ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Image.asset('asset/notice_pin.png',
                              width: 16, height: 16),
                        ),
                      ),
                      Text(
                        boardItem.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: hasImage ? MediaQuery.of(context).size.width * 0.7 : MediaQuery.of(context).size.width-32,
                    child: Text(
                     boardItem.content,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.gray800, fontSize: 13.0),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (hasImage)
                Container( // 이미지 있으면 표시
                width: 64,
                height: 64,
                decoration: ShapeDecoration(
                  color: AppColors.gray100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '${boardItem.user.nickname} | ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              Text(
                viewModel.postCreatedText(boardItem.createdAt.toString()),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColors.gray400, fontSize: 13.0),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Image.asset('asset/comment.png', width: 16, height: 16),
              ),
              Text(boardItem.numOfComments.toString(),
                  style: Theme.of(context)
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
