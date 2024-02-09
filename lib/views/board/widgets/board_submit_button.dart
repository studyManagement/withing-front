import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/modal/withing_modal.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';

class BoardSubmitButton extends StatelessWidget {
  final bool isNew;
  final int? boardId;

  const BoardSubmitButton({super.key, required this.isNew, this.boardId});

  @override
  Widget build(BuildContext context) {
    final BoardViewModel vm = Provider.of<BoardViewModel>(context);
    return TextButton(
      onPressed: () {
             (vm.isValid)
                ? {
               (isNew) ? vm.createPost() : vm.updatePost(boardId!),
                    WithingModal.openDialog(
                        context,vm.getNoticeTitle(isNew),vm.getNoticeContents(isNew), false, () {
                      context
                        ..pop()
                        ..pop();
                      vm.resetPosts();
                      print('resetPost');

                    }, null)
                  }
                : null;
      },
      child: Text("등록",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: (vm.isValid) ? AppColors.blue400 : AppColors.gray300,
              fontSize: 16)),
    );
  }
}
