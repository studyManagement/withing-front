import 'package:flutter/material.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';
import '../../../model/board/board_model.dart';
import '../../../view_models/board/board_viewmodel.dart';
import 'board_item.dart';

class BoardList extends StatelessWidget {
  final int studyId;
  const BoardList({super.key, required this.studyId});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<BoardViewModel>();
    List<BoardModel> list = vm.posts;

    return ListView.separated(
      itemBuilder: (context, index) {
        return BoardItem(
          studyId: studyId,
          isOnlyNotice: false,
          nickname: list[index].user.nickname,
          notice: list[index].notice,
          boardId: list[index].id,
          title: list[index].title,
          content: list[index].content,
          createdAt: list[index].createdAt.toString(),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
          color: AppColors.gray100,
        );
      },
      itemCount: list.length,
    );
  }
}
