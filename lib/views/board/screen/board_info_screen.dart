import 'package:flutter/material.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';
import '../widgets/board_appbar.dart';
import '../widgets/board_bottomsheet.dart';
import '../widgets/board_header.dart';
import '../widgets/comment_input_box.dart';
import '../widgets/comment_list.dart';

class BoardInfoScreen extends StatelessWidget {
  final int studyId;
  final bool isNotice;
  final int boardId;

  const BoardInfoScreen(
      {super.key,
      required this.boardId,
      required this.studyId,
      required this.isNotice});

  @override
  Widget build(BuildContext context) {
    final BoardViewModel vm = context.watch<BoardViewModel>();
    vm.setStudyId = studyId;
    vm.fetchBoardInfo(boardId);
    if(!vm.isDeleted) vm.fetchComments(boardId);
    bool isWriter = vm.post?.user.id == Authentication.instance.userId;
    return Scaffold(
        appBar: boardAppBar(
            context,
            '',
            null,
            (isWriter) ?
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context){
                        return BoardBottomSheet(viewModel: vm,boardId: boardId);
                      });
                },
                icon: const Icon(Icons.more_horiz)):null),
        body: (vm.post == null)
            ? Container()
            : const SafeArea(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(children: [
                        BoardHeader(),
                        Divider(
                          endIndent: 0,
                          thickness: 6,
                          color: AppColors.gray50,
                        ),
                        SizedBox(height: 12),
                        BoardCommentList(),
                      ]),
                    ),
                    Spacer(),
                    Divider(
                      endIndent: 0,
                      color: AppColors.gray50,
                    ),
                    CommentInputBox(),
                  ],
                ),
              ));
  }
}
