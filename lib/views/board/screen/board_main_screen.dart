import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/model/board/board_model.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/views/board/widgets/board_list.dart';
import 'package:modi/views/board/widgets/no_post.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../view_models/board/board_viewmodel.dart';
import '../widgets/board_appbar.dart';

class BoardMainScreen extends StatefulWidget {
  final int studyId;
  final bool isNotice;

  const BoardMainScreen(
      {super.key, required this.studyId, required this.isNotice});

  @override
  State<BoardMainScreen> createState() => _BoardMainScreenState();
}

class _BoardMainScreenState extends State<BoardMainScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BoardViewModel(getIt<BoardService>()),
      child: Consumer<BoardViewModel>(builder: (context, vm, child) {
        vm.setStudyId = widget.studyId;
        vm.fetchNotices();
        if (widget.isNotice == false) {
         vm.fetchBoardList();
        }
        return Scaffold(
            appBar: (widget.isNotice == true)
                ? boardAppBar(context, '공지', null, null)
                : boardAppBar(
                    context,
                    '게시판',
                    null,
                    IconButton(
                        onPressed: () {
                          context.push('/studies/${vm.studyId}/boards/create');
                        },
                        icon: const Icon(Icons.add))),
            body: SafeArea(
                child: (vm.hasPost)
                        ? BoardList(list: (widget.isNotice) ? vm.notices : vm.notices+vm.posts)
                        : const NoPost()));
      }),
    );
  }
}
