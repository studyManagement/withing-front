import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/board_list.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../view_models/board/board_viewmodel.dart';
import '../widgets/board_appbar.dart';

class BoardMainScreen extends StatelessWidget {
  final int studyId;
  final bool isNotice;

  const BoardMainScreen(
      {super.key, required this.studyId, required this.isNotice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (isNotice == true)
          ? boardAppBar(context, '공지', null, null)
          : boardAppBar(
              context,
              '게시판',
              null,
              IconButton(
                  onPressed: () {
                    context.push('/studies/$studyId/boards/create');
                  },
                  icon: const Icon(Icons.add))),
      body: ChangeNotifierProvider(
        create: (_) => BoardViewModel(getIt<BoardService>()),
        child: Consumer<BoardViewModel>(builder: (context, vm, child) {
          if(isNotice == true) {
            vm.fetchNotices(studyId);
          }
          else{
           vm.fetchBoardList(studyId);
          }
          return SafeArea(
              child: (vm.posts.isEmpty) ? Container():
                  (vm.hasPost) ? BoardList(studyId: studyId) : const NoPost());
        }),
      ),
    );
  }
}
