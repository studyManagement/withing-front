import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/board/board_model.dart';
import '../../../view_models/board/board_viewmodel.dart';
import 'board_item.dart';

class BoardList extends StatelessWidget {
  final bool? isNotice;
  const BoardList({super.key,this.isNotice});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final vm = context.watch<BoardViewModel>();
    List<BoardModel> list = (isNotice!) ? vm.notices : vm.notices + vm.posts;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          vm.scrollListener(isNotice!);
        }
        return true;
      },
      child: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          return BoardItem(
            studyId: vm.studyId!,
            isOnlyNotice: false,
            boardItem: list[index],
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
      ),
    );
  }
}
