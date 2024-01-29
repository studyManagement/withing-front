import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:withing/view_models/study/study_viewmodel.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/board/board_model.dart';
import 'board_item.dart';
import 'board_item.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<StudyViewModel>();
    List<BoardModel> list = vm.posts;

    return ListView.separated(
      itemBuilder: (context, index) {
        return BoardItem(
          studyId: vm.study.studyId,
          isOnlyNotice: false,
          nickname: list[index].user.nickname,
          notice: list[index].notice,
          boardId: list[index].id,
          title: list[index].title,
          content:list[index].content,
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
