import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';
import '../../../di/injection.dart';
import '../widgets/board_appbar.dart';
import '../widgets/board_bottomsheet.dart';
import '../widgets/board_header.dart';
import '../widgets/comment_input_box.dart';
import '../widgets/comment_list.dart';

class BoardInfoScreen extends StatefulWidget {
  final int studyId;
  final bool isNotice;
  final int boardId;

  const BoardInfoScreen(
      {super.key,
      required this.boardId,
      required this.studyId,
      required this.isNotice});

  @override
  State<BoardInfoScreen> createState() => _BoardInfoScreenState();
}

class _BoardInfoScreenState extends State<BoardInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BoardViewModel(getIt<BoardService>()),
      child: Consumer<BoardViewModel>(
        builder: (context, vm, child) {
          vm.setStudyId = widget.studyId;
          vm.fetchBoardInfo(widget.boardId);
          if(!vm.isDeleted) vm.fetchComments(widget.boardId);
          bool isWriter = vm.post?.user.id == Authentication.instance.userId;
          return Scaffold(
              appBar: boardAppBar(
                  context,
                  '',
                  (){
                    context.pop();
                    },
                  (isWriter) ?
                  IconButton(
                      onPressed: (){
                        print('open bottom sheet');
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BoardBottomSheet(
                                  viewModel: vm, boardId: widget.boardId);
                            });
                      },
                      icon: const Icon(Icons.more_horiz)) : null),
              body: (vm.post == null)
                  ? Container()
                  : const SafeArea(
                child: Column(
                  children: [
                    Expanded(
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
                        ]),
                      ),
                    ),
                    Divider(
                      endIndent: 0,
                      color: AppColors.gray50,
                    ),
                    CommentInputBox(),
                  ],
                ),
              ));
        }
      ),
    );
  }
}
