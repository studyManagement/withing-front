import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/layout/default_layout.dart';
import 'package:withing/views/board/widgets/board_list.dart';
import 'package:withing/views/board/widgets/no_post.dart';
import '../../../common/theme/app/app_colors.dart';
import '../widgets/board_appbar.dart';

class BoardMainScreen extends StatelessWidget {
  final int studyId;
  final bool isNotice;

  const BoardMainScreen({super.key, required this.studyId,required this.isNotice});

  @override
  Widget build(BuildContext context) {
    bool isExist = true;
    return Scaffold(
        appBar: boardAppBar(context,'게시판',null, IconButton(onPressed: (){
          context.push('/studies/$studyId/board/create');
        }, icon:const Icon(Icons.add))),
        body: SafeArea(
            child: (isExist) ?
                BoardList()
                : const NoPost()
        )
    );
  }
}
