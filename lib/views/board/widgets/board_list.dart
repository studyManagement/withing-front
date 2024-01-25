import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:withing/view_models/study/study_viewmodel.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/study/notice_model.dart';
import '../../study/widgets/notice_item.dart';
import 'board_item.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key});

  @override
  Widget build(BuildContext context) {
    List<NoticeModel> list;

    return ListView.separated(
      itemBuilder: (context, index) {
        return BoardItem(
          nickname: 'nickname',
          notice: 0,
          boardId: 1,
          title: '게시글 제목입니다',
          content: '게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다. 게시글 내용입니다.게시글 내용입니다. 게시글 내용입니다 .게시글 내용입니다. 게시글 내용입니다  ',
          createdAt: '2024-01-20T00:00:00',
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
      itemCount: 10,
    );
  }
}
