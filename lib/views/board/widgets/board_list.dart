import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../model/board/board_model.dart';
import '../../../view_models/board/board_viewmodel.dart';
import 'board_item.dart';

class BoardList extends StatelessWidget {
  final bool? isNotice;
  final bool hasTag;
  const BoardList({super.key, this.isNotice, this.hasTag = false});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final vm = context.watch<BoardViewModel>();
    List<BoardModel> list = vm.posts;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          vm.scrollListener(context);
        }
        return true;
      },
      child: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          return BoardItem(
            boardItem: list[index],
            hasTag: hasTag,
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
