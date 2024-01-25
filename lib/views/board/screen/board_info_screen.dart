import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: boardAppBar(
            context,
            '',
            null,
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const BoardBottomSheet();
                      });
                },
                icon: const Icon(Icons.more_horiz))),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              BoardHeader(),
              Divider(
                endIndent: 0,
                thickness: 6,
                color: AppColors.gray50,
              ),
              SizedBox(height: 12),
              BoardCommentList(),
              Divider(
                endIndent: 0,
                color: AppColors.gray50,
              ),
              CommentInputBox(),
            ]),
          ),
        ));
  }
}
