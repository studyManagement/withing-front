import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/bottom_toast.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/views/board/screen/update_post_screen.dart';

import '../../../common/modal/modi_modal.dart';
import '../../../common/theme/app/app_colors.dart';

class BoardBottomSheet extends StatelessWidget {
  final BoardViewModel viewModel;
  final int boardId;

  const BoardBottomSheet(
      {super.key, required this.viewModel, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width,
      height: 168,
      decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.zero,
              bottomRight: Radius.zero)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 26),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text(viewModel.getToSetNoticeText(),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          onTap: () {
            viewModel.setOrUnsetNotice();
            context.pop();
            // viewModel.refreshBoardList();
          },
        ),
        const SizedBox(height: 12),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text('수정하기', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          onTap: () {
            context.pop();
            viewModel.isValid = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UpdatePostScreen(viewModel: viewModel)));
          },
        ),
        const SizedBox(height: 12),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              Text('삭제하기',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.red400)),
            ],
          ),
          onTap: () {
            ModiModal.openDialog(
                context,
                "\n게시글을 삭제하시겠어요?",
                '',
                true,
                () => {
                      viewModel.deletePost(boardId),
                      viewModel.refreshBoardList(),
                      context
                        ..pop()
                        ..pop()
                        ..pop()
                    },
                null);
          },
        ),
      ]),
    );
  }
}
